
import 'dotenv/config';
import { Bot, InlineKeyboard } from 'grammy';
import { ImageGeneratorFactory } from "./OpenAIImageGenerators";
import { InputFile } from 'grammy';
import fs from "fs";
import path from "path";

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



// --- Инициализация бота ---
const bot = new Bot(token);

import OpenAI from "openai";
// --- Инициализация OpenAI ---
const client = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY, // ключ из .env
});




// Добавляем в начало файла
interface UserState {
  state: string;
  timestamp: number;
}

const userStates = new Map<number, UserState>(); // userId -> UserState
const STATE_TIMEOUT = 10 * 60 * 1000; // 10 минут таймаут для состояния










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
  await ctx.reply("📋 Меню:", {
    reply_markup: mainMenu
  });
});




// Обработка callback-ов от кнопок
bot.on("callback_query:data", async (ctx) => {
  const action = ctx.callbackQuery.data;
  const userId = ctx.from.id;
  
  try {
    switch (action) {
      case "generate_gpt":
        await ctx.answerCallbackQuery();
        await ctx.reply("Введите описание картинки для GPT модели:");
        // Сохраняем состояние с timestamp
        userStates.set(userId, { 
          state: 'waiting_gpt_prompt', 
          timestamp: Date.now() 
        });
        break;
        
      case "generate_dalle":
        await ctx.answerCallbackQuery();
        await ctx.reply("Введите описание картинки для Dalle модели:");
        userStates.set(userId, { 
          state: 'waiting_dalle_prompt', 
          timestamp: Date.now() 
        });
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
    userStates.delete(userId);
  }
});










// Обработка текстовых сообщений (для состояний)
bot.on('message:text', async (ctx) => {
  const userId = ctx.from.id;
  const userStateData = userStates.get(userId);
  const prompt = ctx.message.text;

  // Проверяем есть ли состояние и не устарело ли оно
  if (userStateData && prompt) {
    const now = Date.now();
    const stateAge = now - userStateData.timestamp;
    
    if (stateAge > STATE_TIMEOUT) {
      // Состояние устарело
      userStates.delete(userId);
      await ctx.reply("⏰ Время ожидания истекло. Выберите действие снова через /menu");
      return;
    }

    try {
      // Удаляем состояние
      userStates.delete(userId);
      
      if (userStateData.state === 'waiting_gpt_prompt') {
        await generateAndSendImage(ctx, 'gpt', prompt);
      } else if (userStateData.state === 'waiting_dalle_prompt') {
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


// Обновляем обработку кнопок
bot.on("callback_query:data", async (ctx) => {
  const action = ctx.callbackQuery.data;
  const userId = ctx.from.id;
  
  try {
    switch (action) {
      case "generate_gpt":
        await ctx.answerCallbackQuery();
        userStates.set(userId, { 
          state: 'waiting_gpt_prompt', 
          timestamp: Date.now() 
        });
        await ctx.reply("Введите описание картинки для GPT модели:");
        break;
        
      case "generate_dalle":
        await ctx.answerCallbackQuery();
        userStates.set(userId, { 
          state: 'waiting_dalle_prompt', 
          timestamp: Date.now() 
        });
        await ctx.reply("Введите описание картинки для Dalle модели:");
        break;
        
      // ... остальные cases
    }
  } catch (error) {
    console.error("Ошибка обработки кнопки:", error);
    await ctx.answerCallbackQuery("❌ Ошибка");
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


bot.command("image", async (ctx) => {
  // Показываем меню выбора модели вместо immediate генерации
  const imageMenu = new InlineKeyboard()
    .text("GPT модель", "generate_gpt")
    .text("Dalle модель", "generate_dalle");

  await ctx.reply("🎨 Выберите модель для генерации:", {
    reply_markup: imageMenu
  });
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

// Обновляем команду /give
bot.command("give", giveRandomImage);

function log(section: string, ctx: any) {
  console.log(`${section} section`)
  console.log("prompt:", ctx)
}



// Очищаем состояния каждые 5 минут
setInterval(() => {
  const now = Date.now();
  let clearedCount = 0;

  for (const [userId, stateData] of userStates.entries()) {
    if (now - stateData.timestamp > STATE_TIMEOUT) {
      userStates.delete(userId);
      clearedCount++;
    }
  }

  if (clearedCount > 0) {
    console.log(`🧹 Очищено ${clearedCount} устаревших состояний. Осталось: ${userStates.size}`);
  }
}, 5 * 60 * 1000); // Каждые 5 минут

// Также очищаем при старте
console.log(`🤖 Бот запущен. Очищаем состояния...`);
userStates.clear();



// // Команда для просмотра текущих состояний (только для админов)
// bot.command("states", async (ctx) => {
//   const adminId = 123456789; // Замените на ваш ID
//   if (ctx.from.id !== adminId) {
//     await ctx.reply("❌ Недостаточно прав");
//     return;
//   }

//   const now = Date.now();
//   let message = `📊 Текущие состояния (${userStates.size}):\n\n`;

//   for (const [userId, stateData] of userStates.entries()) {
//     const age = Math.round((now - stateData.timestamp) / 1000);
//     message += `👤 ${userId}: ${stateData.state} (${age} сек назад)\n`;
//   }

//   await ctx.reply(message || "Нет активных состояний");
// });