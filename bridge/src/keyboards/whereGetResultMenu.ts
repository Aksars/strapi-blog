import { InlineKeyboard } from 'grammy';
import { MyContext } from '../types/index.js';

export const whereGetResultMenu = new InlineKeyboard()
    .text("⬅️ Назад", "menu")
    .row()
    .text("🎨 Получить в телегу", "action_just_generate")
    .row()
    .text("🚀 Получить в телегу и отправить в Strapi", "action_generate_and_upload");

export async function showAIMenu(ctx: MyContext) {
    await ctx.editMessageText(`Выберите действие для ${ctx.session.model!.toLocaleUpperCase()}:`, {
        reply_markup: whereGetResultMenu
    });
}
