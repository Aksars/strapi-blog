import { Bot } from 'grammy';
import { MyContext } from '../types/session.js';
import {
  madnessMenu,
  showMainMenu,
  switchMainMenu,
  showStrapiMenu,
  showTextModelMenu,
  showImageModelMenu
} from '../keyboards/index.js';
import FileImageService from '../service/fileImageService.js';
import ImageDeliveryService from '../service/imageDeliveryService.js';
import { ImageGenerationService } from '../service/imageGenerationService.js';
import StrapiService from '../service/strapiService.js';
import { ImageModel, TextModel } from '../types/models.js';
import { TextGenerationService } from '../service/textGenerationService.js';
import { logger } from '../utils/logger.js';
export function setupCallbackHandlers(
  bot: Bot<MyContext>,
  imageDeliveryService: ImageDeliveryService,
  imageGenerationService: ImageGenerationService,
  textGenerationService: TextGenerationService,
  strapiService: StrapiService
) {

  function handleCallback(action: string, handler: (ctx: MyContext) => Promise<void>, bot: Bot<MyContext>) {
    bot.callbackQuery(action, async (ctx) => {
      try {
        await ctx.answerCallbackQuery();
        ctx.session.timestamp = Date.now(); // общая логика
        await handler(ctx);
      } catch (error) {
        logger.error(`❌ Ошибка при обработке ${action}, ${error}`)
        await ctx.answerCallbackQuery(`❌ Ошибка при обработке ${action} подробности в консоли сервера`);
      }
    });
  }


  // Главное меню
  handleCallback("menu", async (ctx) => switchMainMenu(ctx), bot);

  // Выбор типа генерации
  handleCallback("generate_text", async (ctx) => {
    ctx.session.generationType = 'text';
    await showTextModelMenu(ctx);
  }, bot);

  handleCallback("random_image", async (ctx) => {
    const img = await FileImageService.getRandomImage();
    if (img) await imageDeliveryService.sendToTelegram(ctx, img);
    else await ctx.reply("Не получилось отправить ни одну картинку(( 🚧");
    showMainMenu(ctx)
  }, bot);

  handleCallback("generate_image", async (ctx) => {
    ctx.session.generationType = 'image';
    await showImageModelMenu(ctx);
  }, bot);

  handleCallback("get_existing", async (ctx) => {
    // TODO: Реализовать получение существующих файлов
    await ctx.reply("📂 Функция получения существующих файлов в разработке");
    await switchMainMenu(ctx);
  }, bot);

  // Выбор моделей для текста
  handleCallback("text_model_gpt35", async (ctx) => {
    ctx.session.textModel = TextModel.GPT35;
    ctx.session.state = 'waiting_text_prompt';
    await ctx.editMessageText("🧠 Выбрана модель: GPT-3.5 Turbo\n\nВведите текст для генерации:");
  }, bot);

  handleCallback("text_model_gpt4", async (ctx) => {
    ctx.session.textModel = TextModel.GPT4;
    ctx.session.state = 'waiting_text_prompt';
    await ctx.editMessageText("🚀 Выбрана модель: GPT-4\n\nВведите текст для генерации:");
  }, bot);

  handleCallback("text_model_gpt4turbo", async (ctx) => {
    ctx.session.textModel = TextModel.GPT4Turbo;
    ctx.session.state = 'waiting_text_prompt';
    await ctx.editMessageText("⚡ Выбрана модель: GPT-4 Turbo\n\nВведите текст для генерации:");
  }, bot);

  // Выбор моделей для изображений
  handleCallback("image_model_gpt", async (ctx) => {
    ctx.session.imageModel = ImageModel.GPT;
    ctx.session.state = 'waiting_image_prompt';
    await ctx.editMessageText("🎨 Выбрана модель: GPT Image\n\nВведите описание картинки:");
  }, bot);

  handleCallback("image_model_dalle", async (ctx) => {
    ctx.session.imageModel = ImageModel.DALLE;
    ctx.session.state = 'waiting_image_prompt';
    await ctx.editMessageText("🖼️ Выбрана модель: DALL-E\n\nВведите описание картинки:");
  }, bot);

  // Обработка сохранения изображений
  handleCallback("save_yes", async (ctx) => {
    ctx.session.saveToServer = true;
    await handlePostImageMenus(ctx);
  }, bot);

  handleCallback("save_no", async (ctx) => {
    ctx.session.saveToServer = false;
    await handlePostImageMenus(ctx);
  }, bot);

  handleCallback("strapi_yes", async (ctx) => {
    ctx.session.sendToStrapi = true;
    await finalizeImageFlow(ctx, strapiService);
  }, bot);

  handleCallback("strapi_no", async (ctx) => {
    ctx.session.sendToStrapi = false;
    await finalizeImageFlow(ctx, strapiService);
  }, bot);
  
  handleCallback("madnessMenu", async (ctx) => {  
    ctx.session.state = 'waiting_temperature_prompt';
    madnessMenu(ctx)
  }, bot);

 

  // // Обработка текстовой генерации
  // handleCallback("regenerate_text", async (ctx) => {
  //   const prompt = ctx.session.tempData?.prompt;
  //   if (prompt && ctx.session.textModel) {
  //     await generateText(ctx, textGenerationService, prompt, ctx.session.textModel);
  //   } else {
  //     await ctx.editMessageText("❌ Не удалось найти промпт для регенерации");
  //     await switchMainMenu(ctx);
  //   }
  // }, bot);

  handleCallback("new_text", async (ctx) => {
    ctx.session.state = 'waiting_text_prompt';
    await ctx.editMessageText("Введите новый текст для генерации:");
  }, bot);

  // Вспомогательные функции
  async function handlePostImageMenus(ctx: MyContext) {
    await showStrapiMenu(ctx);
  }

  async function finalizeImageFlow(ctx: MyContext, strapiService: StrapiService) {
    const img = ctx.session.tempData?.image;
    const prompt = ctx.session.tempData?.prompt || '';

    if (!img) {
      await ctx.editMessageText("❌ Изображение не найдено");
      return;
    }

    // Сохранение на сервер
    if (ctx.session.saveToServer) {
      try {
        await FileImageService.saveImage(img);
        await ctx.reply("💾 Изображение сохранено на сервер");
      } catch (err) {
        console.error(err);
        await ctx.reply("⚠️ Не удалось сохранить на сервер");
      }
    }

    // Отправка в Strapi
    if (ctx.session.sendToStrapi) {
      try {
        await strapiService.uploadImage(img.buffer, img.filename, prompt);
        await ctx.reply("🚀 Успешно загружено в Strapi!");
      } catch (err) {
        console.error(err);
        await ctx.reply("⚠️ Не удалось загрузить в Strapi");
      }
    }

    // Сброс сессии
    ctx.session.state = undefined;
    ctx.session.tempData = {};

    await ctx.editMessageText("🎉 Генерация завершена!\n\nИспользуйте /menu для нового действия");
    await switchMainMenu(ctx);
  }




  // async function handleTextGeneration(
  //   ctx: MyContext,
  //   textService: TextGenerationService,
  //   prompt: string,
  //   model: TextModel
  // ) {
  //   try {
  //     // Показываем сообщение о начале генерации
  //     const loadingMsg = await ctx.reply("⏳ Генерируем текст...");

  //     // Генерация текста
  //     const result = await textService.generateText(prompt, {
  //       model: model,
  //       temperature: 0.7
  //     });

  //     if (result.success && result.text) {
  //       // Сохраняем результат в сессии
  //       ctx.session.tempData = {
  //         prompt,
  //         generatedText: result.text
  //       };

  //       // Отправляем результат
  //       await ctx.api.editMessageText(
  //         ctx.chat?.id!,
  //         loadingMsg.message_id,
  //         `📝 **Результат генерации:**\n\n${result.text}\n\n` +
  //         `🔧 *Модель: ${model}*\n` +
  //         `📊 *Токенов использовано: ${result.usage?.total_tokens || 'N/A'}*`
  //       );

  //       // Предлагаем действия
  //       await ctx.reply(
  //         "Что дальше?\n\n" +
  //         "• /regenerate - Сгенерировать заново\n" +
  //         "• /new_text - Новый запрос\n" +
  //         "• /menu - Главное меню",
  //         { parse_mode: 'Markdown' }
  //       );

  //     } else {
  //       await ctx.editMessageText(`❌ Ошибка генерации: ${result.error || 'Неизвестная ошибка'}`);
  //       await switchMainMenu(ctx);
  //     }

  //   } catch (error) {
  //     console.error("Ошибка генерации текста:", error);
  //     await ctx.editMessageText("❌ Произошла ошибка при генерации текста");
  //     await switchMainMenu(ctx);
  //   }
  // }
}