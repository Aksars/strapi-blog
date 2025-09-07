import 'dotenv/config';
import { Bot } from 'grammy';

// --- Проверка токена ---
const token = process.env.BOT_TOKEN;
if (!token) {
  console.error("❌ BOT_TOKEN не задан в .env");
  process.exit(1);
}

// --- Инициализация бота ---
const bot = new Bot(token);

// --- Рандомные ответы ---
const replies = [
  "Привет! 👋",
  "Как дела?",
  "Хороший день сегодня!",
  "🤖 Я твой бот",
  "Не могу ответить на это 😅"
];

// --- Обработка любого текста ---
bot.on('message:text', (ctx) => {
  const randomReply = replies[Math.floor(Math.random() * replies.length)];
  ctx.reply(randomReply).catch(console.error);
});

// --- Старт бота ---
bot.start();
console.log("🤖 Бот запущен и слушает сообщения!");
