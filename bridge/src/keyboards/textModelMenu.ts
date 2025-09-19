import { InlineKeyboard } from 'grammy';
import { Context } from 'grammy';

export const textModelMenu = new InlineKeyboard()
  .text("gpt-3.5-turbo", "text_model_3.5")
  .text("gpt-4", "text_model_4")
  .text("gpt-4-turbo", "text_model_4_turbo")
  .row()
  .text("⬅️ Назад", "menu");

export async function showTextModelMenu(ctx: Context) {
  await ctx.editMessageText("Выберите модель для генерации текста:", {
    reply_markup: textModelMenu
  });
}