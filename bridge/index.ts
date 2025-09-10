import 'dotenv/config';
import { Bot } from 'grammy';
import OpenAI from "openai";

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

// --- Обработка любого текста ---
bot.on('message:text', async (ctx) => {
  try {
    // текст от пользователя
    const userMessage = ctx.message.text;

    // запрос в GPT
    const response = await client.responses.create({
      model: "gpt-5-mini", // можно gpt-4.1-mini для скорости и цены
      input: userMessage,
    });

    // ответ от GPT
    const replyText = response.output_text || "🤖 Я не смог придумать ответ";

    await ctx.reply(replyText);
  } catch (error) {
    console.error("Ошибка OpenAI:", error);
    await ctx.reply("⚠️ Ошибка при получении ответа от GPT");
  }
});

// --- Старт бота ---
bot.start();
console.log("🤖 Бот запущен и слушает сообщения!");
