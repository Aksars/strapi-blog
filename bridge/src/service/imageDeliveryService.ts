import { InputFile } from 'grammy';
import type { Context } from 'grammy';
import type { Image, PoorImage } from '../types/image.js';
import StrapiService from './strapiService.js';

export default class ImageDeliveryService {
  private readonly strapiService: StrapiService;

  constructor(strapiService: StrapiService) {
    this.strapiService = strapiService;
  }

  // Отправка изображения в Telegram
  async sendToTelegram(ctx: Context, image: Image | PoorImage, caption: string = ''): Promise<boolean> {
    try {
      if (!image || !image.buffer) {
        console.error("Invalid image provided");
        return false;
      }

      await ctx.replyWithPhoto(
        new InputFile(image.buffer, image.filename),
        { caption }
      );
      return true;
    } catch (error) {
      console.error("Ошибка отправки в Telegram:", error);
      return false;
    }
  }

  // Загрузка изображения в Strapi
  async sendToStrapi(image: Image ): Promise<any> {
    try {
      if (!image || !image.buffer) {
        console.error("Invalid image provided");
        return null;
      }

      const description = image.prompt 
        ? `Сгенерировано ботом: ${image.prompt}`
        : 'Изображение сгенерировано ботом';

      return await this.strapiService.uploadImage(
        image.buffer,
        image.filename,
        description
      );
    } catch (error) {
      console.error("Ошибка загрузки в Strapi:", error);
      return null;
    }
  }

  // Комбинированная отправка: в Telegram и Strapi
  async sendToBoth(ctx: Context, image: Image): Promise<{
    telegramSuccess: boolean;
    strapiSuccess: boolean;
    strapiResult?: any;
  }> {
    try {
      if (!image || !image.buffer) {
        console.error("Invalid image provided");
        return { telegramSuccess: false, strapiSuccess: false };
      }

      // Параллельно отправляем в Telegram и Strapi
      const [telegramResult, strapiResult] = await Promise.allSettled([
        this.sendToTelegram(ctx, image, `🔄 Загружаю в Strapi...`),
        this.sendToStrapi(image)
      ]);

      const telegramSuccess = telegramResult.status === 'fulfilled' && telegramResult.value;
      const strapiSuccess = strapiResult.status === 'fulfilled' && strapiResult.value !== null;

      // Обновляем caption в Telegram после завершения
      let finalCaption = `🎨 "${image.prompt}"\n📁 ${image.filename}`;
      
      if (strapiSuccess) {
        finalCaption = `✅ Загружено в Strapi!\n🎨 "${image.prompt}"\n📁 ${image.filename}\n🔗 ID: ${strapiResult.value.id}`;
      } else {
        finalCaption += `\n⚠️ Не удалось загрузить в Strapi`;
      }

      // Если Telegram отправка не удалась, пытаемся отправить с финальным caption
      if (!telegramSuccess) {
        await this.sendToTelegram(ctx, image, finalCaption);
      }

      return {
        telegramSuccess: telegramSuccess || true,
        strapiSuccess,
        strapiResult: strapiSuccess ? strapiResult.value : undefined
      };

    } catch (error) {
      console.error("Ошибка комбинированной отправки:", error);
      
      // Фолбэк: пытаемся хотя бы в Telegram отправить
      const telegramSuccess = await this.sendToTelegram(
        ctx, 
        image, 
        `🎨 "${image.prompt}"\n📁 ${image.filename}\n⚠️ Ошибка при загрузке в Strapi`
      );

      return {
        telegramSuccess,
        strapiSuccess: false
      };
    }
  }
}
