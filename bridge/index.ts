import { Bot } from "grammy";
import { Client } from "pg";
import OpenAI from "openai";
import "dotenv/config";

// --- Telegram Bot ---
const bot = new Bot(process.env.BOT_TOKEN!);

// --- Postgres ---
const db = new Client({
  host: process.env.DB_HOST,
  port: Number(process.env.DB_PORT),
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
});
db.connect();

// --- OpenAI ---
const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
});

// --- Bot logic ---
bot.command("start", (ctx) =>
  ctx.reply("Привет! Я бот 🤖. Задай вопрос, и я спрошу у ChatGPT.")
);

bot.on("message:text", async (ctx) => {
  const userMsg = ctx.message.text;

  // Сохраним запрос в базу
  await db.query("INSERT INTO messages (user_id, text) VALUES ($1, $2)", [
    ctx.from.id,
    userMsg,
  ]);

  // Отправим запрос в ChatGPT
  const completion = await openai.chat.completions.create({
    model: "gpt-4o-mini",
    messages: [{ role: "user", content: userMsg }],
  });

  const reply = completion.choices[0]?.message?.content ?? "🤔";
  await ctx.reply(reply);
});

bot.start();
