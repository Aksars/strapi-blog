import { Bot, session as grammySession, SessionFlavor, Context } from 'grammy';
import { RedisAdapter } from '@grammyjs/storage-redis';
import { SessionData } from "../types/session.js"; 

export type MyContext = Context & SessionFlavor<SessionData>;
export type SessionStorage = RedisAdapter<SessionData>;

// Создание бота
export function createBot(storage: SessionStorage, token: string) {
    const bot = new Bot<MyContext>(token);

    bot.use(grammySession({
        initial: (): SessionData => (
            {
                state: 'idle',
                timestamp: Date.now(),
                createdAt: Date.now(), // ← время создания сесси
                lastActivity: Date.now() // ← время последней активности
            }
        ),
        getSessionKey: (ctx) => ctx.from?.id.toString(),
        storage,
    }));

    return bot;
};