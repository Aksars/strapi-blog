import { Bot } from 'grammy';
import { MyContext } from '../types/session.js';
import FileImageService from '../service/fileImageService.js';
import ImageDeliveryService from '../service/imageDeliveryService.js';
import ImageGenerationService from '../service/imageGenerationService.js';
import { logger } from '../utils/logger.js';

export function setupMessageHandlers(bot: Bot<MyContext>,
    imageDeliveryService: ImageDeliveryService,
    imageGenerationService: ImageGenerationService) {

    // Обработка текстовых сообщений (для состояний)
    bot.on('message:text', async (ctx) => {
        const prompt = ctx.message.text;
        const STATE_TIMEOUT = 10 * 60 * 1000; // 10 минут

        // Проверяем есть ли состояние в сессии и не устарело ли оно
        if (ctx.session.state && ctx.session.timestamp && prompt) {
            const now = Date.now();
            const stateAge = now - ctx.session.timestamp;

            if (stateAge > STATE_TIMEOUT) {
                await ctx.reply("⏰ Время ожидания истекло. Выберите действие снова через /menu");
                // Полностью очищаем сессию
                ctx.session = {};
                return;
            }

            try {
                const currentState = ctx.session.state;
                const model = ctx.session.model;
                const action = ctx.session.action;
                const saveToServer = ctx.session.saveToServer;

                // Очищаем состояние перед обработкой
                ctx.session = {};

                if (currentState === 'waiting_prompt' && model && action) {
                    await handleImageGeneration(ctx, prompt, model, action, saveToServer);
                } else if (currentState === 'generate_to_strapi') {
                    await handleStrapiGeneration(ctx, prompt);
                }

            } catch (error) {
                console.error("Ошибка обработки промпта:", error);
                await ctx.reply("❌ Ошибка при обработке запроса");
                ctx.session = {};
            }
        } else {
            // Обычное сообщение без состояния
            logger.info("text", ctx);
        }
    });

    // Выносим логику обработки в отдельные функции для чистоты
    async function handleImageGeneration(ctx: any, prompt: string, model: 'gpt' | 'dalle', action: string, saveToServer: boolean = true) {
        await ctx.reply(`🔄 Генерирую картинку моделью ${model}...`);

        const result = await imageGenerationService.generateImage(model, prompt);

        if (!result.success || !result.image) {
            await ctx.reply("❌ Не удалось сгенерировать картинку");
            return;
        }

        // Сохраняем на сервер если нужно
        if (saveToServer) {
            const saved = FileImageService.saveImage(result.image);
            if (saved) {
                await ctx.reply("💾 Изображение сохранено на сервер");
            }
        }

        // Отправляем в Telegram
        const sent = await imageDeliveryService.sendToTelegram(
            ctx,
            result.image,
            `🎨 ${model.toUpperCase()}: "${prompt}"\n📁 ${result.image.filename}`
        );

        if (!sent) {
            await ctx.reply("⚠️ Картинка сгенерирована, но не удалось отправить");
        }

        // Если нужно отправить в Strapi
        if (action === 'generate_and_upload') {
            await ctx.reply("🔄 Отправляю в Strapi...");
            const strapiResult = await imageDeliveryService.sendToStrapi(result.image);

            if (strapiResult) {
                await ctx.reply("✅ Успешно загружено в Strapi!");
            } else {
                await ctx.reply("⚠️ Не удалось загрузить в Strapi");
            }
        }

        await ctx.reply("✅ Готово! Используйте /menu для новых действий");
    }

    async function handleStrapiGeneration(ctx: any, prompt: string) {
        // Старая логика для обратной совместимости
        await ctx.reply(`🔄 Генерирую картинку и загружаю в Strapi...`);

        const result = await imageGenerationService.generateImage('dalle', prompt);

        if (!result.success || !result.image) {
            await ctx.reply("❌ Не удалось сгенерировать картинку");
            return;
        }

        // Сохраняем на сервер по умолчанию
        FileImageService.saveImage(result.image);

        const deliveryResult = await imageDeliveryService.sendToBoth(ctx, result.image);

        if (deliveryResult.strapiSuccess) {
            await ctx.reply("✅ Успешно загружено в Strapi!");
        } else {
            await ctx.reply("⚠️ Изображение отправлено, но возникли проблемы с Strapi");
        }
    }
}

