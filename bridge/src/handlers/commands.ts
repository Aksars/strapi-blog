import { Bot } from 'grammy';
import { MyContext } from '../types/session.js';
import { showMainMenu, showSaveMenu } from '../keyboards/index.js';
import FileImageService from '../service/fileImageService.js';
import ImageDeliveryService from '../service/imageDeliveryService.js';
import { logger } from '../utils/logger.js';
import { DateUtils } from '../utils/dateUtils.js';
import {ImageGenerationService} from '../service/imageGenerationService.js';

export function setupCommandHandlers(bot: Bot<MyContext>, imageDeliveryService: ImageDeliveryService, imageGenerationService:ImageGenerationService) {

    // Команда меню
    bot.command(["menu", "start"], async (ctx) => {
        await showMainMenu(ctx);
    });

    bot.command("test", async (ctx) => {
        // const kb = new InlineKeyboard().webApp("Открыть мини-апп", "https://example.com/app");
        // await ctx.reply("какая то апка в теории:", { reply_markup: kb });
        await ctx.reply("Тестовое сообщение:", {
            reply_markup: { force_reply: true, }
        });
    })

    bot.command("test2", async (ctx) => {
        await ctx.reply("отмена тестового сообщения:", {
            reply_markup: {
                remove_keyboard: true
            }
        });
    })



    // Команда для просмотра текущих сессий (только для админов)
    bot.command("sessions", async (ctx) => {
        logger.info("sessions", ctx);
        const adminId = 936067427;
        if (ctx.from?.id !== adminId) {
            await ctx.reply("❌ Недостаточно прав");
            return;
        }

        // Получаем доступ к хранилищу сессий
        // Note: Это работает только с некоторыми хранилищами
        const storage = (ctx.session as any).storage;

        if (!storage || typeof storage.read !== 'function') {
            await ctx.reply("❌ Хранилище сессий не поддерживает чтение всех данных");
            return;
        }

        try {
            const now = Date.now();
            let message = "📊 Активные сессии:\n\n";
            let sessionCount = 0;

            // Читаем все ключи сессий (зависит от реализации хранилища)
            const keys = await storage.keys();

            for (const key of keys) {
                try {
                    const sessionData = await storage.read(key);
                    if (sessionData && sessionData.state) {
                        const age = Math.round((now - (sessionData.timestamp || 0)) / 1000);
                        const userId = key; // Ключ обычно равен userId

                        message += `👤 ${userId}: ${sessionData.state} (${age} сек назад)\n`;
                        sessionCount++;
                    }
                } catch (error) {
                    message += `👤 ${key}: ошибка чтения\n`;
                }
            }

            await ctx.reply(message || "Нет активных сессий");
            await ctx.reply(`Всего активных сессий: ${sessionCount}`);

        } catch (error) {
            console.error("Ошибка чтения сессий:", error);
            await ctx.reply("❌ Ошибка при чтении сессий");
        }
    });


    bot.command("give", async (ctx) => {
        const img = FileImageService.getRandomImage();
        if (img)
            await imageDeliveryService.sendToTelegram(ctx, img)
        else
            await ctx.reply("❌ Ошибка при чтении сессий");
    })

    bot.command("stats", async (ctx) => {
        const stats = await FileImageService.getImageStats();

        let telegramDate;
        if (ctx.message && ctx.message.date) {
            telegramDate = new Date(ctx.message.date * 1000);
        }
        const mskTimeNow = DateUtils.mskTime();

        // Безопасное использование lastCreated
        const lastCreatedText = stats.lastCreated
            ? DateUtils.smartTimeDiff(stats.lastCreated, telegramDate)
            : 'никогда';

        const message =
            `📦 *Статистика хранилища*\n` +
            `├ 🖼️      ${stats.totalImages} файлов\n` +
            `├ 💾      ${stats.totalSizeMB}\n` +
            `├ 📈      ${stats.avgSizeMB} в среднем\n` +
            `├ ⏰🔄  ${lastCreatedText} по MSK последний апдейт \n` +
            `├ ⏰🖥️  ${mskTimeNow} по MSK на сервере\n` +
            `├ ⏰📨  ${telegramDate ? DateUtils.mskTime(telegramDate) : 'N/A'} время последнего сообщения в ТГ\n` +
            `└ ⏱️💚  ${DateUtils.formatUptime(process.uptime())} Server Uptime`;

        await ctx.reply(message);
    });
// // Использование
// message += `🕐 Создан: ${DateFormatter.relative(file.createdAt)}\n`;

// `├ 📶 ${calculatePing()}ms Пинг\n` +




}