import { readdirSync } from 'fs';
import { dirname, join } from 'path';
import { fileURLToPath } from 'url';
import type { Bot } from 'grammy';
import type { MyContext } from '../types/index.js';

const __dirname = dirname(fileURLToPath(import.meta.url));

interface CommandHandler {
  [key: string]: (ctx: MyContext) => Promise<void>;
}

interface CallbackHandlers {
  [key: string]: (ctx: MyContext) => Promise<void>;
}

export async function setupHandlers(bot: Bot<MyContext>) {
  // Автоматическая регистрация команд
  const commandsDir = join(__dirname, 'commands');
  const commandFiles = readdirSync(commandsDir).filter(file => file.endsWith('.ts'));
  
  for (const file of commandFiles) {
    const commandName = file.replace('.ts', '');
    const module = await import(`./commands/${file}`) as CommandHandler;
    const handler = module[`handle${capitalize(commandName)}`];
    
    if (handler) {
      bot.command(commandName, handler);
      console.log(`✅ Registered command: /${commandName}`);
    }
  }

  // Автоматическая регистрация callback обработчиков
  const callbacksDir = join(__dirname, 'callbacks');
  const callbackFiles = readdirSync(callbacksDir).filter(file => file.endsWith('.ts'));
  
  const callbackHandlers: CallbackHandlers = {};
  
  for (const file of callbackFiles) {
    const module = await import(`./callbacks/${file}`) as CallbackHandlers;
    Object.assign(callbackHandlers, module);
  }

  // Обработка callback'ов
  bot.on("callback_query:data", async (ctx) => {
    const action = ctx.callbackQuery.data;

    try {
      const handler = callbackHandlers[`handle${capitalizeAction(action)}`];
      
      if (handler) {
        await handler(ctx);
      } else {
        console.warn(`⚠️ No handler for action: ${action}`);
        await ctx.answerCallbackQuery();
      }
    } catch (error) {
      console.error("Ошибка обработки кнопки:", error);
      await ctx.answerCallbackQuery("❌ Ошибка");
      ctx.session.state = undefined;
      ctx.session.timestamp = undefined;
    }
  });
}

function capitalize(str: string): string {
  return str.charAt(0).toUpperCase() + str.slice(1);
}

function capitalizeAction(action: string): string {
  return action.split('_')
    .map(word => word.charAt(0).toUpperCase() + word.slice(1))
    .join('');
}