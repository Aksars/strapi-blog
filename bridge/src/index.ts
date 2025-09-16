
import { mainMenu, saveMenu, whereGetResultMenu } from './keyboards/index.js';
import { getTokens, initRedisStorage, createBot, initOpenAI } from './init/index.js';
import { logger } from './utils/logger.js'
import { DateUtils } from "./utils/dateUtils.js";
import ImageGenerationService from "./service/imageGenerationService.js";
import ImageDeliveryService from './service/imageDeliveryService.js';
import StrapiService from "./service/strapiService.js";
import FileImageService from './service/fileImageService.js'
import { Context } from 'grammy';
import { MyContext } from './types/session.js';

// получаем и проверяем токены к боту и chatgpt
const { token, apiToken } = getTokens()

// Инициализируем редис хранилище, openAIClient, и телеграм бота
const openAIClient = initOpenAI(apiToken)
const storage = await initRedisStorage()
const bot = createBot(storage, token)
bot.start();
logger.info(" 🤖 Бот запущен и слушает сообщения!")

// Инициализируем классы для работы с страпи, отправки, и генерации изображений
const strapiService = new StrapiService()
ImageGenerationService.initialize(openAIClient);
ImageDeliveryService.initialize(strapiService);


// Команда старта с меню
bot.command("start", async (ctx) => {
  await ctx.reply("🤖 Выберите действие:", {
    reply_markup: mainMenu
  });
});
async function showMainMenu(ctx: Context) {
  await ctx.reply("📋 Меню:", {
    reply_markup: mainMenu
  });
}

async function showSaveMenu(ctx: Context) {
  await ctx.editMessageText("Сохранить изображение на сервер?", {
    reply_markup: saveMenu
  });
}

// Команда меню
bot.command("menu", async (ctx) => {
  logger.info("menu", ctx);
  await showMainMenu(ctx);
});

bot.callbackQuery("whereGetResultMenu", async (ctx) => {
  await ctx.answerCallbackQuery(); // закрыть "часики"  
  await ctx.editMessageText("📋 Меню:", {
    reply_markup: whereGetResultMenu
  });
});

bot.callbackQuery("menu", async (ctx) => {
  await ctx.answerCallbackQuery(); // закрыть "часики"
  await ctx.editMessageText("📋 Меню:", {
    reply_markup: mainMenu
  });
});

async function showAIMenu(ctx: MyContext) {
  await ctx.editMessageText(`Выберите действие для ${ctx.session.model!.toLocaleUpperCase()}:`, {
    reply_markup: whereGetResultMenu
  });
}

  //await ctx.reply("Выберите действие для GPT:", { reply_markup: gptMenu });
        // await ctx.reply("Напиши свой e-mail:", {
        //   reply_markup: { force_reply: true, }
        // });

// Обработка callback-ов от кнопок
bot.on("callback_query:data", async (ctx) => {
  const action = ctx.callbackQuery.data;

  try {
    switch (action) {
      case "generate_gpt":
        await ctx.answerCallbackQuery();
        // Начинаем многошаговый процесс
        ctx.session.state = 'choosing_action';
        ctx.session.model = 'gpt';
        ctx.session.timestamp = Date.now();

        await showAIMenu(ctx)
        break;

      case "generate_dalle":
        await ctx.answerCallbackQuery();
        ctx.session.state = 'choosing_action';
        ctx.session.model = 'dalle';
        ctx.session.timestamp = Date.now();

        await showAIMenu(ctx)
        break;

      case "action_just_generate":
        await ctx.answerCallbackQuery();
        ctx.session.action = 'generate';
        ctx.session.state = 'choosing_save_option';
        ctx.session.timestamp = Date.now();

        await showSaveMenu(ctx)
        break;

      case "action_generate_and_upload":
        await ctx.answerCallbackQuery();
        ctx.session.action = 'generate_and_upload';
        ctx.session.state = 'choosing_save_option';
        ctx.session.timestamp = Date.now();

        await showSaveMenu(ctx)
        break;

      case "save_yes":
        await ctx.answerCallbackQuery();
        ctx.session.saveToServer = true;
        ctx.session.state = 'waiting_prompt';
        ctx.session.timestamp = Date.now();

        await ctx.editMessageText("💾 Буду сохранять на сервер. Теперь введите описание картинки:");
        break;

      case "save_no":
        await ctx.answerCallbackQuery();
        ctx.session.saveToServer = false;
        ctx.session.state = 'waiting_prompt';
        ctx.session.timestamp = Date.now();

        await ctx.editMessageText("🚫 Не буду сохранять на сервер. Теперь введите описание картинки:");
        break;

      case "random_image":
        await ctx.answerCallbackQuery();
        const img = await FileImageService.getRandomImage();
        if (img)
          await ImageDeliveryService.sendToTelegram(ctx, img)
        else
          await ctx.reply("Не получилось отправить ни одну картинку(( 🚧");
        break;

      case "generate_text":
        await ctx.answerCallbackQuery();
        await ctx.reply("Генерация текста скоро будет доступна! 🚧");
        break;

    }
  } catch (error) {
    console.error("Ошибка обработки кнопки:", error);
    await ctx.answerCallbackQuery("❌ Ошибка");
    // Очищаем состояние при ошибке
    ctx.session.state = undefined;
    ctx.session.timestamp = undefined;
    ctx.session.model = undefined;
    ctx.session.action = undefined;
    ctx.session.saveToServer = undefined;
  }
});





bot.command("test", async (ctx) => {
  // await ctx.reply("Выбери:", {
  //   reply_markup: {
  //     keyboard: [
  //       [{ text: "Кнопка 1" }, { text: "Кнопка 2" }],
  //       [{ text: "Поделиться номером", request_contact: true }],
  //       [{ text: "Поделиться геопозицией", request_location: true }]
  //     ],
  //     resize_keyboard: true,
  //     one_time_keyboard: true
  //   }
  // });

  // await ctx.reply("Напиши свой e-mail:", {
  //   reply_markup: { force_reply: true }
  // });
})

// Команда для просмотра текущих сессий (только для админов)
bot.command("sessions", async (ctx) => {
  logger.info("sessions", ctx);
  const adminId = 936067427;
  if (ctx.from?.id !== adminId) {
    await ctx.reply("❌ Недостаточно прав");
    return;
  }

  // Получаем доступ к хранилищу сессий
  // Note: Это работает только с некоторыми хранилищами
  const storage = (ctx.session as any).storage;

  if (!storage || typeof storage.read !== 'function') {
    await ctx.reply("❌ Хранилище сессий не поддерживает чтение всех данных");
    return;
  }

  try {
    const now = Date.now();
    let message = "📊 Активные сессии:\n\n";
    let sessionCount = 0;

    // Читаем все ключи сессий (зависит от реализации хранилища)
    const keys = await storage.keys();

    for (const key of keys) {
      try {
        const sessionData = await storage.read(key);
        if (sessionData && sessionData.state) {
          const age = Math.round((now - (sessionData.timestamp || 0)) / 1000);
          const userId = key; // Ключ обычно равен userId

          message += `👤 ${userId}: ${sessionData.state} (${age} сек назад)\n`;
          sessionCount++;
        }
      } catch (error) {
        message += `👤 ${key}: ошибка чтения\n`;
      }
    }

    await ctx.reply(message || "Нет активных сессий");
    await ctx.reply(`Всего активных сессий: ${sessionCount}`);

  } catch (error) {
    console.error("Ошибка чтения сессий:", error);
    await ctx.reply("❌ Ошибка при чтении сессий");
  }
});


bot.command("give", async (ctx) => {
  const img = FileImageService.getRandomImage();
  if (img)
    await ImageDeliveryService.sendToTelegram(ctx, img)
  else
    await ctx.reply("❌ Ошибка при чтении сессий");
})

bot.command("stats", async (ctx) => {
  const stats = await FileImageService.getImageStats();

  let telegramDate;
  if (ctx.message && ctx.message.date) {
    telegramDate = new Date(ctx.message.date * 1000);
  }
  const mskTimeNow = DateUtils.mskTime();

  // Безопасное использование lastCreated
  const lastCreatedText = stats.lastCreated
    ? DateUtils.smartTimeDiff(stats.lastCreated, telegramDate)
    : 'никогда';

  const message =
    `📦 *Статистика хранилища*\n` +
    `├ 🖼️      ${stats.totalImages} файлов\n` +
    `├ 💾      ${stats.totalSizeMB}\n` +
    `├ 📈      ${stats.avgSizeMB} в среднем\n` +
    `├ ⏰🔄  ${lastCreatedText} по MSK последний апдейт \n` +
    `├ ⏰🖥️  ${mskTimeNow} по MSK на сервере\n` +
    `├ ⏰📨  ${telegramDate ? DateUtils.mskTime(telegramDate) : 'N/A'} время последнего сообщения в ТГ\n` +
    `└ ⏱️💚  ${DateUtils.formatUptime(process.uptime())} Server Uptime`;

  await ctx.reply(message);
});

// `├ 📶 ${calculatePing()}ms Пинг\n` +


// // Использование
// message += `🕐 Создан: ${DateFormatter.relative(file.createdAt)}\n`;











// Обработка текстовых сообщений (для состояний)
bot.on('message:text', async (ctx) => {
  const prompt = ctx.message.text;
  const STATE_TIMEOUT = 10 * 60 * 1000; // 10 минут

  // Проверяем есть ли состояние в сессии и не устарело ли оно
  if (ctx.session.state && ctx.session.timestamp && prompt) {
    const now = Date.now();
    const stateAge = now - ctx.session.timestamp;

    if (stateAge > STATE_TIMEOUT) {
      await ctx.reply("⏰ Время ожидания истекло. Выберите действие снова через /menu");
      // Полностью очищаем сессию
      ctx.session = {};
      return;
    }

    try {
      const currentState = ctx.session.state;
      const model = ctx.session.model;
      const action = ctx.session.action;
      const saveToServer = ctx.session.saveToServer;

      // Очищаем состояние перед обработкой
      ctx.session = {};

      if (currentState === 'waiting_prompt' && model && action) {
        await handleImageGeneration(ctx, prompt, model, action, saveToServer);
      } else if (currentState === 'generate_to_strapi') {
        await handleStrapiGeneration(ctx, prompt);
      }

    } catch (error) {
      console.error("Ошибка обработки промпта:", error);
      await ctx.reply("❌ Ошибка при обработке запроса");
      ctx.session = {};
    }
  } else {
    // Обычное сообщение без состояния
    logger.info("text", ctx);
  }
});

// Выносим логику обработки в отдельные функции для чистоты
async function handleImageGeneration(ctx: any, prompt: string, model: 'gpt' | 'dalle', action: string, saveToServer: boolean = true) {
  await ctx.reply(`🔄 Генерирую картинку моделью ${model}...`);

  const result = await ImageGenerationService.generateImage(model, prompt);

  if (!result.success || !result.image) {
    await ctx.reply("❌ Не удалось сгенерировать картинку");
    return;
  }

  // Сохраняем на сервер если нужно
  if (saveToServer) {
    const saved = FileImageService.saveImage(result.image);
    if (saved) {
      await ctx.reply("💾 Изображение сохранено на сервер");
    }
  }

  // Отправляем в Telegram
  const sent = await ImageDeliveryService.sendToTelegram(
    ctx,
    result.image,
    `🎨 ${model.toUpperCase()}: "${prompt}"\n📁 ${result.image.filename}`
  );

  if (!sent) {
    await ctx.reply("⚠️ Картинка сгенерирована, но не удалось отправить");
  }

  // Если нужно отправить в Strapi
  if (action === 'generate_and_upload') {
    await ctx.reply("🔄 Отправляю в Strapi...");
    const strapiResult = await ImageDeliveryService.sendToStrapi(result.image);

    if (strapiResult) {
      await ctx.reply("✅ Успешно загружено в Strapi!");
    } else {
      await ctx.reply("⚠️ Не удалось загрузить в Strapi");
    }
  }

  await ctx.reply("✅ Готово! Используйте /menu для новых действий");
}

async function handleStrapiGeneration(ctx: any, prompt: string) {
  // Старая логика для обратной совместимости
  await ctx.reply(`🔄 Генерирую картинку и загружаю в Strapi...`);

  const result = await ImageGenerationService.generateImage('dalle', prompt);

  if (!result.success || !result.image) {
    await ctx.reply("❌ Не удалось сгенерировать картинку");
    return;
  }

  // Сохраняем на сервер по умолчанию
  FileImageService.saveImage(result.image);

  const deliveryResult = await ImageDeliveryService.sendToBoth(ctx, result.image);

  if (deliveryResult.strapiSuccess) {
    await ctx.reply("✅ Успешно загружено в Strapi!");
  } else {
    await ctx.reply("⚠️ Изображение отправлено, но возникли проблемы с Strapi");
  }
}







// Middleware для проверки времени сессии
bot.use(async (ctx, next) => {
  const STATE_TIMEOUT = 10 * 60 * 1000;

  if (ctx.session.timestamp) {
    const now = Date.now();
    if (now - ctx.session.timestamp > STATE_TIMEOUT) {
      // Очищаем устаревшую сессию
      ctx.session.state = undefined;
      ctx.session.timestamp = undefined;
    }
  }

  await next();
});


// Middleware для обновления времени последней активности
bot.use(async (ctx, next) => {
  if (ctx.session && !ctx.session.createdAt) {
    ctx.session.createdAt = Date.now(); // первое использование
  }
  ctx.session.lastActivity = Date.now(); // обновляем при каждом сообщении
  await next();
});




// bot.command("image", async (ctx) => {
//   // Показываем меню выбора модели вместо immediate генерации
//   const imageMenu = new InlineKeyboard()
//     .text("GPT модель", "generate_gpt")
//     .text("Dalle модель", "generate_dalle");

//   await ctx.reply("🎨 Выберите модель для генерации:", {
//     reply_markup: imageMenu
//   });
// });

