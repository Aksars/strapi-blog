
import 'dotenv/config';
import { Bot } from 'grammy';
import OpenAI from "openai";
import fs from "fs";
import path from "path";
import { InputFile } from 'grammy';
import fetch from "node-fetch";


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

// --- Инициализация OpenAI ---
const client = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY, // ключ из .env
});

// --- Инициализация бота ---
const bot = new Bot(token);









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

  const startTotal = Date.now(); // для общего времени

  try {
    const prompt = ctx.match || "Собака в космосе";
    console.log("Промпт:", prompt);

    console.log("Начало генерации картинки");
    console.time("Генерация картинки");

   // const image = await gptImage1(prompt)
    const b64 = await dalle2Image(prompt)




    console.log(`Общее время выполнения: ${Date.now() - startTotal}ms`);

    await ctx.reply("✅ Картинка сгенерирована и сохранена!");
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



async function gptImage1(prompt: string) {
  const result = await client.images.generate({
    model: "gpt-image-1",
    quality: "low",
    prompt,
    size: "1024x1024",
  });

  console.timeEnd("Генерация картинки");
  console.log("Сгенерировался результат ", result);

  const b64 = result.data ? result.data[0].b64_json : null;

  if (!b64) {
    console.log("⚠️ Не удалось получить картинку");
    return;
  }
  console.log("Декодируем картинку в Buffer");
  console.time("Сохранение картинки");
  const buffer = Buffer.from(b64, "base64");

  const filename = `${Date.now()}_image.png`;
  const filepath = path.join("./images", filename);
  fs.writeFileSync(filepath, buffer);
  console.timeEnd("Сохранение картинки");

  console.log(`Картинка сохранена: ${filepath}`);
  return filepath
}


async function dalle2Image(prompt: string) {
  const result = await client.images.generate({
    model: "dall-e-2",
    prompt: prompt,
    n: 1,
    size: "1024x1024",
  });

  console.timeEnd("Генерация картинки");
  console.log("Сгенерировался результат ", result);

  const url = result.data?.[0]?.url;
  if (!url) {
    console.log("⚠️ Не удалось получить ссылку на картинку");
    return null;
  }

  console.log("Скачиваем картинку по URL");
  console.time("Сохранение картинки");

  // Скачиваем файл по URL
  const response = await fetch(url);
  const buffer = Buffer.from(await response.arrayBuffer());

  // Имя файла
  const filename = `${Date.now()}_image.png`;
  const filepath = path.join("./images", filename);

  // Сохраняем на диск
  fs.writeFileSync(filepath, buffer);

  console.timeEnd("Сохранение картинки");
  console.log(`Картинка сохранена: ${filepath}`);

  return filepath;
}

// // декодируем Base64 в Buffer
// const buffer = Buffer.from(b64, "base64");

// // отправляем фото напрямую через Buffer
// await ctx.replyWithPhoto({ source: buffer }, { caption: `Вот твоя картинка: ${prompt}` });


// const imageUrl =  result.data?result.data[0].url:null
// if (!imageUrl) {
//   await ctx.reply("⚠️ Не удалось сгенерировать картинку");
//   return;
// }

// await ctx.replyWithPhoto(imageUrl, { caption: `Вот твоя картинка: ${prompt}` });
