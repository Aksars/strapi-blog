
import { InlineKeyboard } from 'grammy';
import { ImageGeneratorFactory } from "./core/openAIGenerators.js";
import { InputFile } from 'grammy';
import { getTokens, initRedisStorage, createBot, initOpenAI } from './initialization/index.js';
import { logger } from './utils/logger.js'
import { ImageService } from './core/imageService.js';
import { StrapiService } from './core/strapiService.js';

// Инициализируем Strapi сервис
const strapiService = new StrapiService();

// получаем и проверяем токены к боту и chatgpt
const { token, apiToken } = getTokens()

// Инициализируем редис хранилище, openAIClient, и телеграм бота
const openAIClient = initOpenAI(apiToken)
const storage = await initRedisStorage()
const bot = createBot(storage, token)
bot.start();
logger.info(" 🤖 Бот запущен и слушает сообщения!")

const imageService = new ImageService(openAIClient);

// создаем меню бота через билдер
const mainMenu = new InlineKeyboard()
  .text("🖼 Сгенерировать картинку (GPT)", "generate_gpt")
  .text("🎨 Сгенерировать картинку (Dalle)", "generate_dalle")
  .text("🔄 Сгенерировать + Strapi", "generate_to_strapi")
  .row()
  .text("🎲 Случайная картинка", "random_image")
  .text("📝 Сгенерировать текст", "generate_text")

// Команда старта с меню
bot.command("start", async (ctx) => {
  await ctx.reply("🤖 Выберите действие:", {
    reply_markup: mainMenu
  });
});

// Команда меню
bot.command("menu", async (ctx) => {
  logger.info("menu", ctx);
  await ctx.reply("📋 Меню:", {
    reply_markup: mainMenu
  });
});



// Обработка callback-ов от кнопок
bot.on("callback_query:data", async (ctx) => {
  const action = ctx.callbackQuery.data;

  try {
    switch (action) {
      case "generate_gpt":
        await ctx.answerCallbackQuery();
        // Используем сессию вместо userStates
        ctx.session.state = 'waiting_gpt_prompt';
        ctx.session.timestamp = Date.now();
        await ctx.reply("Введите описание картинки для GPT модели:");
        break;
 
      case "generate_dalle":
        await ctx.answerCallbackQuery();
        ctx.session.state = 'waiting_dalle_prompt';
        ctx.session.timestamp = Date.now();
        await ctx.reply("Введите описание картинки для Dalle модели:");
        break;

      case "random_image":
        await ctx.answerCallbackQuery();
        await imageService.sendRandomImageFromFolder(ctx);
        break;

      case "generate_text":
        await ctx.answerCallbackQuery();
        await ctx.reply("Генерация текста скоро будет доступна! 🚧");
        break;

      case "generate_to_strapi":
        await ctx.answerCallbackQuery();
        ctx.session.state = 'generate_to_strapi';
        ctx.session.timestamp = Date.now();    
        await ctx.reply("Введите описание картинки для Страпи:");   
        break;
    }
  } catch (error) {
    console.error("Ошибка обработки кнопки:", error);
    await ctx.answerCallbackQuery("❌ Ошибка");
    // Очищаем состояние при ошибке
    ctx.session.state = undefined;
    ctx.session.timestamp = undefined;
  }
});



async function generateAndSendToStrapi(ctx: any, prompt: string) {
  try {
    await ctx.reply(`🔄 Генерирую картинку и загружаю в Strapi...`);

    // Можно выбрать модель по умолчанию или дать выбор
    const generator = ImageGeneratorFactory.createGenerator('dalle', openAIClient);
    const result = await generator.generate(prompt);

    if (!result) {
      await ctx.reply("⚠️ Не удалось сгенерировать картинку");
      return;
    }

    logger.info("вызываю загрузку в страпи")
    
    // Загружаем в Strapi
    const strapiMedia = await strapiService.uploadImage(
      result.buffer,
      result.filename,
      `Сгенерировано ботом: ${prompt}`
    );

    if (strapiMedia) {
      await ctx.replyWithPhoto(
        new InputFile(result.buffer, result.filename),
        {
          caption: `✅ Загружено в Strapi!\n🎨 "${prompt}"\n📁 ${result.filename}\n🔗 ID: ${strapiMedia.id}`
        }
      );
    } else {
      await ctx.replyWithPhoto(
        new InputFile(result.buffer, result.filename),
        {
          caption: `🎨 "${prompt}"\n📁 ${result.filename}\n⚠️ Не удалось загрузить в Strapi`
        }
      );
    }

  } catch (err) {
    console.error("Ошибка генерации для Strapi:", err);
    await ctx.reply("⚠️ Ошибка при генерации или загрузке в Strapi");
  }
}



async function generateAndSendImage(ctx: any, model: 'gpt' | 'dalle', prompt: string) {
  try {
    await ctx.reply(`🔄 Генерирую картинку моделью ${model}...`);

    const generator = ImageGeneratorFactory.createGenerator(model, openAIClient);
    const result = await generator.generate(prompt);

    if (!result) {
      await ctx.reply("⚠️ Не удалось сгенерировать картинку");
      return;
    }



    await ctx.replyWithPhoto(
      new InputFile(result.buffer, result.filename),
      {
        caption: `🎨 ${model.toUpperCase()}: "${prompt}"\n📁 ${result.filename}`
      }
    );

    await ctx.reply("✅ Готово! Используйте /menu для новых действий");

  } catch (err) {
    console.error("Ошибка генерации:", err);
    await ctx.reply("⚠️ Ошибка при генерации картинки");
  }
}








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


bot.command("give", (ctx) => imageService.sendRandomImageFromFolder(ctx));

bot.command("stats", async (ctx) => {
  const stats = await imageService.getImageStats();

  let telegramDate;
  if (ctx.message && ctx.message.date) {
    telegramDate = new Date(ctx.message.date * 1000);
  }
  const mskTimeNow = mskTime()

  const message =
    `📦 *Статистика хранилища*\n` +
    `├ 🖼️      ${stats.totalImages} файлов\n` +
    `├ 💾      ${stats.totalSizeMB}\n` +
    `├ 📈      ${stats.avgSizeMB} в среднем\n` +
    `├ ⏰🔄  ${smartTimeDiff(stats.lastCreated, telegramDate)} по MSK последний апдейт \n` +
    `├ ⏰🖥️  ${mskTimeNow} по MSK на сервере\n` +
    `├ ⏰📨  ${telegramDate ? mskTime(telegramDate) : 'N/A'} время последнего сообщения в ТГ\n` +   
    `└ ⏱️💚  ${formatUptime(process.uptime())} Server Uptime`;
  await ctx.reply(message);
});

// `├ 📶 ${calculatePing()}ms Пинг\n` +

function smartTimeDiff(date: Date, now: Date = new Date(), timeZone: string = 'Europe/Moscow'): string {
  const diffMs = now.getTime() - date.getTime();
  const diffDays = Math.floor(diffMs / (1000 * 60 * 60 * 24));

  const timeStr = date.toLocaleTimeString('ru-RU', {
    hour: '2-digit',
    minute: '2-digit',
    timeZone: timeZone
  });

  if (diffDays < 1) {
    return `Сегодня в ${timeStr}`;
  } else if (diffDays === 1) {
    return `Вчера в ${timeStr}`;
  } else if (diffDays < 7) {
    return `${diffDays} дн. назад в ${timeStr}`;
  } else {
    return date.toLocaleDateString('ru-RU', {
      day: '2-digit',
      month: '2-digit',
      year: 'numeric',
      timeZone: timeZone
    });
  }
}


function formatUptime(seconds: number): string {
    const days = Math.floor(seconds / (24 * 60 * 60));
    const hours = Math.floor((seconds % (24 * 60 * 60)) / (60 * 60));
    const minutes = Math.floor((seconds % (60 * 60)) / 60);
    
    const parts = [];
    if (days > 0) parts.push(`${days}д`);
    if (hours > 0) parts.push(`${hours}ч`);
    if (minutes > 0) parts.push(`${minutes}м`);
    
    return parts.join(' ') || '0м';
}



function mskTime(date: Date = new Date()) {
  return date.toLocaleTimeString('ru-RU', {
    hour: '2-digit',
    minute: '2-digit',
    second: '2-digit',
    timeZone: 'Europe/Moscow'
  })
}



// utils/dateFormatter.ts
export const DateFormatter = {
  relative: (date: Date): string => {
    const now = new Date();
    const diffMs = now.getTime() - date.getTime();
    const diffDays = Math.floor(diffMs / (1000 * 60 * 60 * 24));
    const diffHours = Math.floor(diffMs / (1000 * 60 * 60));
    const diffMinutes = Math.floor(diffMs / (1000 * 60));

    if (diffDays > 0) return `${diffDays} дн. назад`;
    if (diffHours > 0) return `${diffHours} час. назад`;
    if (diffMinutes > 0) return `${diffMinutes} мин. назад`;
    return 'только что';
  },

  exact: (date: Date): string => {
    return date.toLocaleString('ru-RU', {
      day: '2-digit',
      month: '2-digit',
      year: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    });
  }
};

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
      // Состояние устарело
      await ctx.reply("⏰ Время ожидания истекло. Выберите действие снова через /menu");
      // Очищаем сессию
      ctx.session.state = undefined;
      ctx.session.timestamp = undefined;
      return;
    }

    try {
      const currentState = ctx.session.state;

      // Очищаем состояние перед обработкой
      ctx.session.state = undefined;
      ctx.session.timestamp = undefined;

      if (currentState === 'waiting_gpt_prompt') {
        await generateAndSendImage(ctx, 'gpt', prompt);
      } else if (currentState === 'waiting_dalle_prompt') {
        await generateAndSendImage(ctx, 'dalle', prompt);
      }else if(currentState === 'generate_to_strapi'){
        await generateAndSendToStrapi(ctx, prompt)
      }
      
    } catch (error) {
      console.error("Ошибка обработки промпта:", error);
      await ctx.reply("❌ Ошибка при обработке запроса");
    }
  } else {
    // Обычное сообщение без состояния

    logger.info("text", ctx);
  }
});








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


