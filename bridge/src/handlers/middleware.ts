import { Bot } from 'grammy';
import { MyContext } from '../types/session.js';

export function setupMiddlewareHandlers(bot: Bot<MyContext>) {

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
}