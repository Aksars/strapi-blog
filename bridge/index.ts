
import 'dotenv/config';
import { Bot } from 'grammy';
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








bot.command("give", async (ctx) => {
  try {
    // Получаем список всех файлов в папке images
    const imagesDir = path.join("./images");
    const files = fs.readdirSync(imagesDir);

    if (!files.length) {
      await ctx.reply("⚠️ В папке images пока нет картинок.");
      return;
    }

    // Например, отдаём случайную картинку
    const randomFile = files[Math.floor(Math.random() * files.length)];
    const filePath = path.join(imagesDir, randomFile);

    const photoStream = fs.createReadStream(filePath);
    await ctx.replyWithPhoto(
      new InputFile(photoStream, randomFile),
      { caption: `Вот твоя картинка: ${randomFile}` }
    );

  } catch (err) {
    console.error(err);
    await ctx.reply("❌ Ошибка при отправке картинки.");
  }
});











bot.command("image", async (ctx) => {
  console.log("Команда /image получена");

  try {
    const model = 'gpt';
    const prompt = ctx.match || "Собака в космосе";
    console.log("Промпт:", prompt);

    // Отправляем сообщение о начале генерации
    await ctx.reply(`🔄 Генерирую картинку моделью ${model}`);
    console.log("Начинаю генерировать картинку моделью :", model);
    
    const generator = ImageGeneratorFactory.createGenerator(model, client);
    const result = await generator.generate(prompt);
    
    

    if (!result) {
      await ctx.reply("⚠️ Не удалось сгенерировать картинку");
      return;
    }

    // Отправляем картинку пользователю
    console.time("Отправка картинки в Telegram");
    
    await ctx.replyWithPhoto(
      new InputFile(result.buffer, result.filename),
      { 
        caption: `🎨 Ваша картинка: "${prompt}"\n📁 Сохранена как: ${result.filename}` 
      }
    );
    
    console.timeEnd("Отправка картинки в Telegram");
    
    await ctx.reply("✅ Картинка сгенерирована и отправлена!");

  } catch (err) {
    console.error("Ошибка генерации картинки:", err);
    await ctx.reply("⚠️ Ошибка при генерации картинки");
  }
});











// --- Обработка любого текста ---
bot.on('message:text', async (ctx) => {
  log("text", ctx)
});

// --- Старт бота ---
bot.start();
console.log("🤖 Бот запущен и слушает сообщения!");





function log(section: string, ctx: any) {
  console.log(`${section} section`)
  console.log("prompt:", ctx)
}

