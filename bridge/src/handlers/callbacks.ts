import { Bot } from 'grammy';
import { MyContext } from '../types/session.js';
import { showAIMenu, switchMainMenu, showSaveMenu } from '../keyboards/index.js';
import FileImageService from '../service/fileImageService.js';
import ImageDeliveryService from '../service/imageDeliveryService.js';
import { logger } from '../utils/logger.js';
import ImageGenerationService from '../service/imageGenerationService.js';

export function setupCallbackHandlers(bot: Bot<MyContext>, imageDeliveryService: ImageDeliveryService, imageGenerationService:ImageGenerationService) {
    
    handleCallback("whereGetResultMenu", async (ctx) => {
        await showAIMenu(ctx)
    }, bot);

    handleCallback("menu", async (ctx) => {
        await switchMainMenu(ctx)
    }, bot);

    handleCallback("generate_gpt", async (ctx) => {
        ctx.session.state = 'choosing_action';
        ctx.session.model = 'gpt';
        await showAIMenu(ctx);
    }, bot);

    handleCallback("generate_dalle", async (ctx) => {
        ctx.session.state = 'choosing_action';
        ctx.session.model = 'dalle';
        await showAIMenu(ctx);
    }, bot);

    handleCallback("action_just_generate", async (ctx) => {
        ctx.session.action = 'generate';
        ctx.session.state = 'choosing_save_option';
        await showSaveMenu(ctx);
    }, bot);

    handleCallback("action_generate_and_upload", async (ctx) => {
        ctx.session.action = 'generate_and_upload';
        ctx.session.state = 'choosing_save_option';
        await showSaveMenu(ctx);
    }, bot);

    handleCallback("save_yes", async (ctx) => {
        ctx.session.saveToServer = true;
        ctx.session.state = 'waiting_prompt';
        await ctx.editMessageText("💾 Буду сохранять на сервер. Теперь введите описание картинки:");
    }, bot);

    handleCallback("save_no", async (ctx) => {
        ctx.session.saveToServer = false;
        ctx.session.state = 'waiting_prompt';
        await ctx.editMessageText("🚫 Не буду сохранять на сервер. Теперь введите описание картинки:");
    }, bot);

    handleCallback("random_image", async (ctx) => {
        const img = await FileImageService.getRandomImage();
        if (img) await imageDeliveryService.sendToTelegram(ctx, img);
        else await ctx.reply("Не получилось отправить ни одну картинку(( 🚧");
    }, bot);

    handleCallback("generate_text", async (ctx) => {
        await ctx.reply("Генерация текста скоро будет доступна! 🚧");
    }, bot);
}

function handleCallback(action: string, handler: (ctx: MyContext) => Promise<void>, bot: Bot<MyContext>) {
    bot.callbackQuery(action, async (ctx) => {
        try {
            await ctx.answerCallbackQuery();
            ctx.session.timestamp = Date.now(); // общая логика
            await handler(ctx);
        } catch (error) {
            logger.error(`❌ Ошибка при обработке ${action}, ${error}`)
            await ctx.answerCallbackQuery(`❌ Ошибка при обработке ${action} подробности в консоли сервера`);
        }
    });
}



