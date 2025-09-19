import OpenAI from "openai";
import fetch from "node-fetch";
import { ImageModel } from "../types/models.js";
import type{ Image } from "../types/image.js";

export interface ImageGenerationResult {
  success: boolean;
  image?: Image;
  error?: string;
}

export interface BatchImageGenerationOptions {
  delayBetweenRequests?: number; // задержка между запросами в ms
}

export class ImageGenerationService {
  private readonly openAIClient: OpenAI;

  // === Глобальный контроль конкуренции (очередь FIFO) ===
  private static activeRequests = 0;
  private static readonly queue: (() => void)[] = []; // массив резолверов ожидающих задач
  private static readonly MAX_CONCURRENCY = 5;

  constructor(openAIClient: OpenAI) {
    this.openAIClient = openAIClient;
  }

  // --- Очередь с семафором ---
  private async withConcurrencyLimit<T>(task: () => Promise<T>): Promise<T> {
    if (ImageGenerationService.activeRequests >= ImageGenerationService.MAX_CONCURRENCY) {
      // ждем пока кто-то освободит слот
      await new Promise<void>((resolve) => {
        ImageGenerationService.queue.push(resolve);
      });
    }

    ImageGenerationService.activeRequests++;
    try {
      return await task();
    } finally {
      ImageGenerationService.activeRequests--;
      // если кто-то ждет в очереди — запускаем его
      const next = ImageGenerationService.queue.shift();
      if (next) next();
    }
  }

  // === Основные методы ===

  async generateImage(model: ImageModel, prompt: string): Promise<ImageGenerationResult> {
    return this.withConcurrencyLimit(async () => {
      try {
        console.time(`Генерация ${model}`);

        let image: Image | null = null;
        if (model === ImageModel.GPT) {
          image = await this.generateWithGPT(prompt, model);
        } else
        if (model === ImageModel.DALLE) {
          image = await this.generateWithDalle(prompt, model);
        }

        if (!image) {
          return { success: false, error: "Не удалось сгенерировать картинку" };
        }

        console.timeEnd(`Генерация ${model}`);
        return { success: true, image };
      } catch (error) {
        console.error("Ошибка генерации:", error);
        return { success: false, error: "Ошибка при генерации картинки" };
      }
    });
  }

  // Генерация нескольких картинок
  async generateMultipleImages(
    model: ImageModel,
    prompts: string[],
    options: BatchImageGenerationOptions = {}
  ): Promise<ImageGenerationResult[]> {
    const { delayBetweenRequests = 0 } = options;
    const results: ImageGenerationResult[] = [];

    for (let i = 0; i < prompts.length; i++) {
      const res = await this.generateImage(model, prompts[i]);
      results.push(res);

      if (i < prompts.length - 1 && delayBetweenRequests > 0) {
        await this.delay(delayBetweenRequests);
      }
    }

    return results;
  }

  // Генерация вариаций одного промпта
  async generateImageVariations(
    model: ImageModel,
    prompt: string,
    count: number = 4,
    options: BatchImageGenerationOptions = {}
  ): Promise<ImageGenerationResult[]> {
    const prompts = Array(count).fill(prompt);
    return this.generateMultipleImages(model, prompts, options);
  }

  // Метод для опытных пользователей с возможностью указать concurrency
  async generateMultipleImagesAdvanced(
    model: ImageModel,
    prompts: string[],
    customConcurrency: number = 3, 
    options: BatchImageGenerationOptions = {}
  ): Promise<ImageGenerationResult[]> {
    const concurrency = this.validateAndLimitConcurrency(customConcurrency);

    const results: ImageGenerationResult[] = [];
    const queue = [...prompts];

    console.log(`⚡ Продвинутая генерация: concurrency: ${concurrency}`);

    while (queue.length > 0) {
      const batch = queue.splice(0, concurrency);
      const batchPromises = batch.map(prompt =>
        this.generateImage(model, prompt)
      );

      const batchResults = await Promise.all(batchPromises);
      results.push(...batchResults);

      if (queue.length > 0 && options.delayBetweenRequests) {
        await this.delay(options.delayBetweenRequests);
      }
    }

    return results;
  }

  // === Вспомогательные методы ===

  // Валидация и ограничение concurrency
  private validateAndLimitConcurrency(requestedConcurrency?: number): number {
    const concurrency = requestedConcurrency ?? 3; // дефолт прямо тут

    const limitedConcurrency = Math.min(
      Math.max(1, concurrency), // не меньше 1
      ImageGenerationService.MAX_CONCURRENCY // не больше максимума
    );

    if (requestedConcurrency !== undefined && requestedConcurrency !== limitedConcurrency) {
      console.warn(`⚠️ Concurrency ограничен с ${requestedConcurrency} до ${limitedConcurrency}`);
    }

    return limitedConcurrency;
  }

  private async generateWithGPT(prompt: string, model: ImageModel): Promise<Image | null> {
    try {
      const result = await this.openAIClient.images.generate({
        model: "gpt-image-1",
        quality: "low",
        prompt,
        size: "1024x1024",
      });

      const b64 = result.data?.[0]?.b64_json;
      if (!b64) {
        console.log("⚠️ GPT: Не удалось получить картинку");
        return null;
      }

      const buffer = Buffer.from(b64, "base64");
      const filename = this.generateFilename(model);

      return { buffer, filename, prompt, model, size: buffer.length };
    } catch (error) {
      console.error("GPT генерация ошибка:", error);
      return null;
    }
  }

  private async generateWithDalle(prompt: string, model: ImageModel): Promise<Image | null> {
    try {
      const result = await this.openAIClient.images.generate({
        model: "dall-e-2",
        prompt,
        n: 1,

      });

      const url = result.data?.[0]?.url;
      if (!url) {
        console.log("⚠️ Dalle: Не удалось получить URL");
        return null;
      }

      const response = await fetch(url);
      const buffer = Buffer.from(await response.arrayBuffer());
      const filename = this.generateFilename(model);

      return { buffer, filename, prompt, model, size: buffer.length };
    } catch (error) {
      console.error("Dalle генерация ошибка:", error);
      return null;
    }
  }

  private generateFilename(model: string): string {
    return `${Date.now()}_${model}_image.png`;
  }

  validatePrompt(prompt: string): { isValid: boolean; message?: string } {
    if (!prompt || prompt.trim().length < 3) {
      return { isValid: false, message: "Промпт слишком короткий" };
    }
    if (prompt.length > 1000) {
      return { isValid: false, message: "Промпт слишком длинный" };
    }
    return { isValid: true };
  }

  private delay(ms: number): Promise<void> {
    return new Promise((resolve) => setTimeout(resolve, ms));
  }

  // Геттеры
  static get maxConcurrency(): number {
    return this.MAX_CONCURRENCY;
  }

}
