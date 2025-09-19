import { InlineKeyboard } from 'grammy';
import { Context } from 'grammy';

export const saveMenu = new InlineKeyboard()
  .text("⬅️ Назад", "choose_image_model")
  .row()
  .text("💾 Да", "save_yes")    
  .text("🚫 Нет", "save_no");

export async function showSaveMenu(ctx: Context) {
  await ctx.editMessageText("Сохранить изображение на сервер?", {
    reply_markup: saveMenu
  });
}