import OpenAI from "openai";
import { TextModel } from '../types/models.js';

export interface TextGenerationOptions {
  model: TextModel;
  temperature?: number;
  max_tokens?: number;
}

export interface TextGenerationResult {
  success: boolean;
  text?: string;
  error?: string;
  usage?: {
    prompt_tokens: number;
    completion_tokens: number;
    total_tokens: number;
  };
}

export class TextGenerationService {
  private readonly openAIClient: OpenAI;

  // === Очередь и контроль конкуренции ===
  private static activeRequests = 0;
  private static readonly queue: (() => void)[] = [];
  private static readonly MAX_CONCURRENCY = 5; // безопасный лимит для GPT-4

  constructor(openAIClient: OpenAI) {
    this.openAIClient = openAIClient;
  }

  // --- Семафор / очередь ---
  private async withConcurrencyLimit<T>(task: () => Promise<T>): Promise<T> {
    if (TextGenerationService.activeRequests >= TextGenerationService.MAX_CONCURRENCY) {
      await new Promise<void>(resolve => TextGenerationService.queue.push(resolve));
    }

    TextGenerationService.activeRequests++;
    try {
      return await task();
    } finally {
      TextGenerationService.activeRequests--;
      const next = TextGenerationService.queue.shift();
      if (next) next();
    }
  }

  // === Основные методы ===

  async generateText(
    prompt: string, 
    options: TextGenerationOptions = { model: TextModel.GPT35 }
  ): Promise<TextGenerationResult> {
    return this.withConcurrencyLimit(async () => {
      try {
        console.time(`Генерация текста ${options.model}`);

        const result = await this.openAIClient.chat.completions.create({
          model: options.model,
          messages: [{ role: "user", content: prompt }],
          temperature: options.temperature ?? 0.7,
          max_tokens: options.max_tokens,
        });

        const text = result.choices[0]?.message?.content;

        console.timeEnd(`Генерация текста ${options.model}`);

        if (!text) {
          return { success: false, error: "Не удалось сгенерировать текст" };
        }

        return { success: true, text, usage: result.usage };
      } catch (error) {
        console.error("Ошибка генерации текста:", error);
        return { 
          success: false, 
          error: error instanceof Error ? error.message : "Ошибка при генерации текста" 
        };
      }
    });
  }

  async generateTextWithSystemPrompt(
    systemPrompt: string,
    userPrompt: string,
    options: TextGenerationOptions = { model: TextModel.GPT35 }
  ): Promise<TextGenerationResult> {
    return this.withConcurrencyLimit(async () => {
      try {
        console.time(`Генерация с системным промптом ${options.model}`);

        const result = await this.openAIClient.chat.completions.create({
          model: options.model,
          messages: [
            { role: "system", content: systemPrompt },
            { role: "user", content: userPrompt }
          ],
          temperature: options.temperature ?? 0.7,
          max_tokens: options.max_tokens,
        });

        const text = result.choices[0]?.message?.content;

        console.timeEnd(`Генерация с системным промптом ${options.model}`);

        if (!text) {
          return { success: false, error: "Не удалось сгенерировать текст" };
        }

        return { success: true, text, usage: result.usage };
      } catch (error) {
        console.error("Ошибка генерации текста:", error);
        return { 
          success: false, 
          error: error instanceof Error ? error.message : "Ошибка при генерации текста" 
        };
      }
    });
  }

  async generateMultipleTexts(
    prompts: string[],
    options: TextGenerationOptions = { model: TextModel.GPT35 }
  ): Promise<TextGenerationResult[]> {
    const results: TextGenerationResult[] = [];

    for (const prompt of prompts) {
      const result = await this.generateText(prompt, options);
      results.push(result);
    }

    return results;
  }

  // === Валидация ===
  validatePrompt(prompt: string): { isValid: boolean; message?: string } {
    if (!prompt || prompt.trim().length < 3) {
      return { isValid: false, message: "Промпт слишком короткий" };
    }

    if (prompt.length > 4000) {
      return { isValid: false, message: "Промпт слишком длинный (макс. 4000 символов)" };
    }

    return { isValid: true };
  }

  normalizeTemperature(temp: number){     
    temp = temp>0?temp:0
    temp = temp<2?temp:2    
    return temp;
  }

  validateOptions(options: TextGenerationOptions): { isValid: boolean; message?: string } {
    if (options.temperature && (options.temperature < 0 || options.temperature > 2)) {
      return { isValid: false, message: "Temperature должен быть между 0 и 2" };
    }

    if (options.max_tokens && options.max_tokens < 1) {
      return { isValid: false, message: "Max tokens должен быть положительным числом" };
    }

    return { isValid: true };
  }

  // === Дополнительно можно геттер для текущей очереди ===
  static get activeCount(): number {
    return this.activeRequests;
  }

  static get queueLength(): number {
    return this.queue.length;
  }
}
