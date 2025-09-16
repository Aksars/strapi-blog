import { Bot, session as grammySession} from 'grammy';
import { SessionData, MyContext, SessionStorage } from "../types/session.js"; 


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