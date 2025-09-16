import { InlineKeyboard } from 'grammy';

export const saveMenu = new InlineKeyboard()
    .text("⬅️ Назад", "whereGetResultMenu")
    .row()
    .text("💾 Да", "save_yes")    
    .text("🚫 Нет", "save_no");

