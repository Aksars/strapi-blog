import OpenAI from "openai";
import fetch from "node-fetch";

export interface Image {
  buffer: Buffer;
  filename: string;
  prompt: string;
  model: string;
  size: number;
}

export interface ImageGenerationResult {
  success: boolean;
  image?: Image;
  error?: string;
}

export default class ImageGenerationService {
  private readonly openAIClient: OpenAI;

  constructor(openAIClient: OpenAI) {
    this.openAIClient = openAIClient;
  }

  // Основной метод генерации
  async generateImage(model: 'gpt' | 'dalle', prompt: string): Promise<ImageGenerationResult> {
    try {
      console.time(`Генерация ${model}`);
      
      let image: Image | null = null;

      if (model === 'gpt') {
        image = await this.generateWithGPT(prompt, model);
      } else if (model === 'dalle') {
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
  }

  // Генерация через GPT
  private async generateWithGPT(prompt: string, model: string): Promise<Image | null> {
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

      return {
        buffer,
        filename,
        prompt,
        model,
        size: buffer.length
      };

    } catch (error) {
      console.error("GPT генерация ошибка:", error);
      return null;
    }
  }

  // Генерация через Dalle
  private async generateWithDalle(prompt: string, model: string): Promise<Image | null> {
    try {
      const result = await this.openAIClient.images.generate({
        model: "dall-e-2",
        prompt,
        n: 1,
        size: "1024x1024",
      });

      const url = result.data?.[0]?.url;
      if (!url) {
        console.log("⚠️ Dalle: Не удалось получить URL");
        return null;
      }

      const response = await fetch(url);
      const buffer = Buffer.from(await response.arrayBuffer());
      const filename = this.generateFilename(model);

      return {
        buffer,
        filename,
        prompt,
        model,
        size: buffer.length
      };

    } catch (error) {
      console.error("Dalle генерация ошибка:", error);
      return null;
    }
  }

  // Генерация имени файла
  private generateFilename(model: string): string {
    return `${Date.now()}_${model}_image.png`;
  }

  // Валидация промпта
  validatePrompt(prompt: string): { isValid: boolean; message?: string } {
    if (!prompt || prompt.trim().length < 3) {
      return { isValid: false, message: "Промпт слишком короткий" };
    }

    if (prompt.length > 1000) {
      return { isValid: false, message: "Промпт слишком длинный" };
    }

    return { isValid: true };
  }
}
