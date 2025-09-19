import { InlineKeyboard } from 'grammy';
import { MyContext } from '../types/session.js';

export const strapiMenu = new InlineKeyboard()
    .text("⬅️ Назад", "menu")
    .row()
    .text("🚀 Да", "strapi_yes")
    .text("❌ Нет", "strapi_no");

export async function showStrapiMenu(ctx: MyContext) {
  await ctx.editMessageText("Отправить изображение в Strapi?", {
    reply_markup: strapiMenu
  });
}