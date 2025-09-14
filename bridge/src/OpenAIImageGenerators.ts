import OpenAI from "openai";
import fs from "fs";
import path from "path";
import fetch from "node-fetch";

export interface ImageGenerationResult {
  buffer: Buffer;
  filename: string;
}

export abstract class BaseImageGenerator {
  constructor(protected readonly client: OpenAI) {}

  abstract generate(prompt: string): Promise<ImageGenerationResult | null>;

  protected saveImage(buffer: Buffer, model: string): ImageGenerationResult {
    const filename = `${Date.now()}_${model}_image.png`;
    const filepath = path.join("./images", filename);
    
    if (!fs.existsSync("./images")) {
      fs.mkdirSync("./images", { recursive: true });
    }
    
    fs.writeFileSync(filepath, buffer);
    
    return { buffer, filename };
  }
}

export class GPTImageGenerator extends BaseImageGenerator {
  async generate(prompt: string): Promise<ImageGenerationResult | null> {
    console.time("Генерация GPT");
    
    const result = await this.client.images.generate({
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
    const resultData = this.saveImage(buffer, "gpt");
    
    console.timeEnd("Генерация GPT");
    return resultData;
  }
}

export class DalleImageGenerator extends BaseImageGenerator {
  async generate(prompt: string): Promise<ImageGenerationResult | null> {
    console.time("Генерация Dalle");
    
    const result = await this.client.images.generate({
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
    const resultData = this.saveImage(buffer, "dalle");
    
    console.timeEnd("Генерация Dalle");
    return resultData;
  }
}

export class ImageGeneratorFactory {
  static createGenerator(type: 'gpt' | 'dalle', client: OpenAI): BaseImageGenerator {
    switch (type) {
      case 'gpt': return new GPTImageGenerator(client);
      case 'dalle': return new DalleImageGenerator(client);
      default: throw new Error('Unknown generator type');
    }
  }
}