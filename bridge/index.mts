import 'dotenv/config';
import { Bot, InlineKeyboard, session as grammySession, Context } from 'grammy';
import { ImageGeneratorFactory } from "./OpenAIImageGenerators.js";

import { InputFile } from 'grammy';
import fs from "fs";
import path from "path";
import OpenAI from "openai";
import { Redis } from "ioredis";
import { RedisAdapter } from "@grammyjs/storage-redis";


// --- Проверка токена ---
const token = process.env.BOT_TOKEN;
if (!token) {
  console.error("❌ BOT_TOKEN не задан в .env");
  process.exit(1);
}

const apiToken = process.env.OPENAI_API_KEY;
if (!apiToken) {
  console.error("❌ OPENAI_API_KEY не задан в .env");
  process.exit(1);
}

const redis = new Redis({
  host: "redis", // 👈 имя контейнера из docker-compose
  port: 6379,
});

// Обработка ошибок подключения
redis.on('error', (err) => {
  console.error('❌ Redis error:', err);
});

redis.on('connect', () => {
  console.log('✅ Connected to Redis');
});

try {
  await redis.ping();
  console.log('✅ Redis ping successful');
} catch (error) {
  console.error('❌ Redis not available:', error);
}

const storage = new RedisAdapter({
  instance: redis, // ← Передаем инстанс
  ttl: 60 * 60 * 24, // Опционально: время жизни в секундах (24 часа)
});


// --- Инициализация бота с правильным типом ---
const bot = new Bot<MyContext>(token);

// --- Определяем интерфейс сессии ---
interface SessionData {
  state?: 'waiting_gpt_prompt' | 'waiting_dalle_prompt'| 'idle';
  timestamp?: number;
  // Добавляем другие поля, которые могут понадобиться
}

// --- Создаем тип контекста с сессией ---
type MyContext = Context & {
  session: SessionData;
};

// Настройка сессий с Redis
bot.use(grammySession({
  initial: (): SessionData => ({ state: 'idle' }),
  getSessionKey: (ctx) => ctx.from?.id.toString(),
  storage: storage, 
}));

//state:idle



// --- Инициализация OpenAI ---
const client = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
});



// Добавляем после инициализации бота
const mainMenu = new InlineKeyboard()
  .text("🖼 Сгенерировать картинку (GPT)", "generate_gpt")
  .text("🎨 Сгенерировать картинку (Dalle)", "generate_dalle")
  .row()
  .text("🎲 Случайная картинка", "random_image")
  .text("📝 Сгенерировать текст", "generate_text");

// Команда старта с меню
bot.command("start", async (ctx) => {
  await ctx.reply("🤖 Выберите действие:", {
    reply_markup: mainMenu
  });
});

// Команда меню
bot.command("menu", async (ctx) => {
  log("menu", ctx);
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
        await giveRandomImage(ctx);
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
  }
});





async function generateAndSendImage(ctx: any, model: 'gpt' | 'dalle', prompt: string) {
  try {
    await ctx.reply(`🔄 Генерирую картинку моделью ${model}...`);
    
    const generator = ImageGeneratorFactory.createGenerator(model, client);
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


// bot.command("image", async (ctx) => {
//   // Показываем меню выбора модели вместо immediate генерации
//   const imageMenu = new InlineKeyboard()
//     .text("GPT модель", "generate_gpt")
//     .text("Dalle модель", "generate_dalle");

//   await ctx.reply("🎨 Выберите модель для генерации:", {
//     reply_markup: imageMenu
//   });
// });


// Команда для просмотра текущих сессий (только для админов)
bot.command("sessions", async (ctx) => {
  log("sessions", ctx);
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


bot.command("give", giveRandomImage);



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
      }
    } catch (error) {
      console.error("Ошибка обработки промпта:", error);
      await ctx.reply("❌ Ошибка при обработке запроса");
    }
  } else {
    // Обычное сообщение без состояния
   
    log("text", ctx);
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


// --- Старт бота ---
bot.start();
console.log("🤖 Бот запущен и слушает сообщения!");







// Выносим логику команды /give в отдельную функцию
async function giveRandomImage(ctx: any) {
  try {
    const imagesDir = path.join("./images");
    const files = fs.readdirSync(imagesDir);

    if (!files.length) {
      await ctx.reply("⚠️ В папке images пока нет картинок.");
      return;
    }

    const randomFile = files[Math.floor(Math.random() * files.length)];
    const filePath = path.join(imagesDir, randomFile);

    const photoStream = fs.createReadStream(filePath);
    await ctx.replyWithPhoto(
      new InputFile(photoStream, randomFile),
      { caption: `🎲 Случайная картинка: ${randomFile}` }
    );

  } catch (err) {
    console.error(err);
    await ctx.reply("❌ Ошибка при отправке картинки.");
  }
}

function log(section: string, ctx: any) {
  console.log(`${section} section`)
  console.log("prompt:", ctx)
}



