import { Bot } from 'grammy';
import { MyContext } from '../types/session.js';
import { switchMainMenu, showTextActions, showImageActions } from '../keyboards/index.js';
import { ImageGenerationService } from '../service/imageGenerationService.js';
import { TextGenerationService } from '../service/textGenerationService.js';
import { ImageModel, TextModel } from '../types/models.js';
import { InputFile } from 'grammy';
import ImageDeliveryService from '../service/imageDeliveryService.js';
import StrapiService from '../service/strapiService.js';

export function setupMessageHandlers(
  bot: Bot<MyContext>,
   imageDeliveryService: ImageDeliveryService,
   imageGenerationService: ImageGenerationService,
   textGenerationService: TextGenerationService,
   strapiService: StrapiService
) {
  // Обработка текстовых сообщений
  bot.on('message:text', async (ctx) => {
    const session = ctx.session;
    const messageText = ctx.message.text;

    // Пропускаем команды
    if (messageText.startsWith('/')) {
      return;
    }

    try {
      switch (session.state) {
        case 'waiting_text_prompt':
          await handleTextPrompt(ctx, messageText);
          break;

        case 'waiting_image_prompt':
          await handleImagePrompt(ctx, messageText);
          break;

        case 'waiting_temperature_prompt':
          await handleMadnessPrompt(ctx, messageText);
          break;          

        default:
          // Если нет активного состояния, показываем меню
          await ctx.reply("Выберите действие через /menu");
          break;
      }
    } catch (error) {
      console.error("Ошибка обработки сообщения:", error);
      await ctx.reply("❌ Произошла ошибка при обработке запроса");
      await switchMainMenu(ctx);
    }
  });




   // Отправляем результат
        // await ctМодель: ${model}*\n` +
        //   `📊 *Токенов использовано: ${result.usage?.total_tokens || 'N/A'}*`
        // );

        // // Предлагаем действия
        // await ctx.reply(
        //   "Что дальше?\n\n" +
        //   "• /regenerate - Сгенерировать заново\n" +
        //   "• /new_text - Новый запрос\n" +
        //   "• /menu - Главное меню",
        //   { parse_mode: 'Markdown' }
        // );x.api.editMessageText(
        //   ctx.chat?.id!,         
        //   `📝 **Результат генерации:**\n\n${result.text}\n\n` +
        //   `🔧 *

//  async function generateText(params: {
//   ctx: MyContext;
//   textService: TextGenerationService;
//   prompt: string;
//   model: TextModel;
//   temperature?: number ;
// }) {
//   const { ctx, textService, prompt, model } = params;
//   let {temperature = 0.8 } = params
//     try {
//       //температура от 0 до 2; t < 2 ==> 2
//       temperature = temperature < 0 ? 0 : temperature
//       temperature = temperature > 2 ? 2 : temperature;
//       // Показываем сообщение о начале генерации
//       await ctx.reply("⏳ Генерируем текст...");

//       // Генерация текста
//       const result = await textService.generateText(prompt, {
//         model: model,
//         temperature: temperature
//       });

//       if (result.success && result.text) {
//         // Сохраняем результат в сессии
//         ctx.session.tempData = {
//           prompt,
//           generatedText: result.text
//         };      

//       } else {
//         await ctx.editMessageText(`❌ Ошибка генерации: ${result.error || 'Неизвестная ошибка'}`);
//         await switchMainMenu(ctx);
//       }

//     } catch (error) {
//       console.error("Ошибка генерации текста:", error);
//       await ctx.editMessageText("❌ Произошла ошибка при генерации текста");
//       await switchMainMenu(ctx);
//     }
//   }


async function handleMadnessPrompt(ctx: MyContext, prompt: string) {
  
}

  // Обработка текстового промпта
  async function handleTextPrompt(ctx: MyContext, prompt: string) {
    const session = ctx.session;

    if (!session.textModel) {
      await ctx.reply("❌ Модель не выбрана. Используйте /menu");
      return;
    }

    // Валидация промпта
    const validation = textGenerationService.validatePrompt(prompt);
    if (!validation.isValid) {
      await ctx.reply(`❌ ${validation.message}`);
      return;
    }

    // Сохраняем промпт в сессии
    session.tempData = { prompt };

    // Показываем сообщение о начале генерации
    const loadingMsg = await ctx.reply("⏳ Генерируем текст...");
 //температура от 0 до 2; t < 2 ==> 2
    
      // temperature = temperature < 0 ? 0 : temperature
      // temperature = temperature > 2 ? 2 : temperature;
    try {
      // Генерация текста
      const result = await textGenerationService.generateText(prompt, {
        model: session.textModel ,
        temperature: 0.7,
        max_tokens: 1000
      });

      if (result.success && result.text) {
        // Обновляем сообщение о загрузке на результат
        await ctx.api.editMessageText(
          ctx.chat?.id!,
          loadingMsg.message_id,
          `📝 **Результат генерации:**\n\n${result.text}\n\n` +
          `🔧 *Модель: ${session.textModel}*\n` +
          `📊 *Токенов использовано: ${result.usage?.total_tokens || 'N/A'}*`,
          { parse_mode: 'Markdown' }
        );

        // Сохраняем сгенерированный текст в сессии
        session.tempData.generatedText = result.text;

        // Показываем действия после генерации
        await showTextActions(ctx);

      } else {
        await ctx.api.editMessageText(
          ctx.chat?.id!,
          loadingMsg.message_id,
          `❌ Ошибка генерации: ${result.error || 'Неизвестная ошибка'}`
        );
        await switchMainMenu(ctx);
      }

    } catch (error) {
      console.error("Ошибка генерации текста:", error);
      await ctx.api.editMessageText(
        ctx.chat?.id!,
        loadingMsg.message_id,
        "❌ Произошла ошибка при генерации текста"
      );
      await switchMainMenu(ctx);
    } finally {
      session.state = undefined;
    }
  }
















  // Обработка промпта для изображений
  async function handleImagePrompt(ctx: MyContext, prompt: string) {
    const session = ctx.session;

    if (!session.imageModel) {
      await ctx.reply("❌ Модель не выбрана. Используйте /menu");
      return;
    }

    // Валидация промпта
    const validation = imageGenerationService.validatePrompt(prompt);
    if (!validation.isValid) {
      await ctx.reply(`❌ ${validation.message}`);
      return;
    }

    // Сохраняем промпт в сессии
    session.tempData = { prompt };

    // Показываем сообщение о начале генерации
    const loadingMsg = await ctx.reply("🎨 Генерируем изображение...");

    try {
      // Генерация изображения
      const result = await imageGenerationService.generateImage(
        session.imageModel ,
        prompt
      );

      if (result.success && result.image) {
        // Сохраняем изображение в сессии
        session.tempData.image = result.image;

        // Отправляем изображение
        await ctx.api.sendPhoto(
          ctx.chat?.id!,
          new InputFile(result.image.buffer, result.image.filename),
          {
            caption: `🖼️ **Сгенерировано:** ${prompt}\n🔧 *Модель: ${session.imageModel}*`,
            parse_mode: 'Markdown'
          }
        );

        // Удаляем сообщение о загрузке
        await ctx.api.deleteMessage(ctx.chat?.id!, loadingMsg.message_id);

        // Показываем действия после генерации
        await showImageActions(ctx);

      } else {
        await ctx.api.editMessageText(
          ctx.chat?.id!,
          loadingMsg.message_id,
          `❌ Ошибка генерации: ${result.error || 'Неизвестная ошибка'}`
        );
        await switchMainMenu(ctx);
      }

    } catch (error) {
      console.error("Ошибка генерации изображения:", error);
      await ctx.api.editMessageText(
        ctx.chat?.id!,
        loadingMsg.message_id,
        "❌ Произошла ошибка при генерации изображения"
      );
      await switchMainMenu(ctx);
    } finally {
      session.state = undefined;
    }
  }

  // Обработка команды регенерации текста
  bot.command('regenerate', async (ctx) => {
    const session = ctx.session;
    const prompt = session.tempData?.prompt;
    const textModel = session.textModel;

    if (!prompt || !textModel) {
      await ctx.reply("❌ Нет данных для регенерации. Начните новую генерацию через /menu");
      return;
    }

    // Показываем сообщение о начале генерации
    const loadingMsg = await ctx.reply("⏳ Регенерируем текст...");

    try {
      const result = await textGenerationService.generateText(prompt, {
        model: textModel,
        temperature: 0.7,
        max_tokens: 1000
      });

      if (result.success && result.text) {
        // Обновляем сообщение о загрузке на результат
        await ctx.api.editMessageText(
          ctx.chat?.id!,
          loadingMsg.message_id,
          `📝 **Результат регенерации:**\n\n${result.text}\n\n` +
          `🔧 *Модель: ${textModel}*\n` +
          `📊 *Токенов использовано: ${result.usage?.total_tokens || 'N/A'}*`,
          { parse_mode: 'Markdown' }
        );

        // Обновляем сгенерированный текст в сессии
        session.tempData!.generatedText = result.text;

        // Показываем действия после генерации
        await showTextActions(ctx);

      } else {
        await ctx.api.editMessageText(
          ctx.chat?.id!,
          loadingMsg.message_id,
          `❌ Ошибка регенерации: ${result.error || 'Неизвестная ошибка'}`
        );
      }

    } catch (error) {
      console.error("Ошибка регенерации текста:", error);
      await ctx.api.editMessageText(
        ctx.chat?.id!,
        loadingMsg.message_id,
        "❌ Произошла ошибка при регенерации текста"
      );
    }
  });

  // Обработка команды нового текста
  bot.command('new_text', async (ctx) => {
    ctx.session.state = 'waiting_text_prompt';
    ctx.session.textModel = ctx.session.textModel || TextModel.GPT35;
    
    await ctx.reply(
      `🧠 Модель: ${ctx.session.textModel}\n\nВведите текст для генерации:`
    );
  });

  // Обработка команды нового изображения
  bot.command('new_image', async (ctx) => {
    ctx.session.state = 'waiting_image_prompt';
    ctx.session.imageModel = ctx.session.imageModel || ImageModel.GPT;
    
    await ctx.reply(
      `🎨 Модель: ${ctx.session.imageModel}\n\nВведите описание картинки:`
    );
  });
}