import { InlineKeyboard } from 'grammy';
import { Context } from 'grammy';

export const imageModelMenu = new InlineKeyboard()
  .text("GPT", "image_model_gpt")
  .text("Dalle", "image_model_dalle")
  .row()
  .text("⬅️ Назад", "menu");

export async function showImageModelMenu(ctx: Context) {
  await ctx.editMessageText("Выберите модель для генерации картинки:", {
    reply_markup: imageModelMenu
  });
}