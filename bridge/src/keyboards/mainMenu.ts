import { InlineKeyboard } from 'grammy';
import { Context } from 'grammy';

export const mainMenu = new InlineKeyboard()
  .text("🖼 Сгенерировать картинку (GPT)", "generate_gpt")
  .text("🎨 Сгенерировать картинку (Dalle)", "generate_dalle")
  .row()
  .text("🎲 Случайная картинка", "random_image")
  .text("📝 Сгенерировать текст", "generate_text");


export async function showMainMenu(ctx: Context) {
  await ctx.reply("📋 Меню:", {
    reply_markup: mainMenu
  });
}


export async function switchMainMenu(ctx: Context) {
  await ctx.editMessageText("📋 Меню:", {
    reply_markup: mainMenu
  });
}