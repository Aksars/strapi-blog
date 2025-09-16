import { InlineKeyboard } from 'grammy';

export const whereGetResultMenu = new InlineKeyboard()
    .text("⬅️ Назад", "menu")
    .row()
    .text("🎨 Получить в телегу", "action_just_generate")
    .row()
    .text("🚀 Получить в телегу и отправить в Strapi", "action_generate_and_upload");
