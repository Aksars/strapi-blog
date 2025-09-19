import { InlineKeyboard } from 'grammy';
import { Context } from 'grammy';

export const mainMenu = new InlineKeyboard()
    .text('📝 Генерировать текст', 'generate_text')
    .text('🎨 Генерировать картинку', 'generate_image')
    .row()
    .text('🎨 Случайная картинка', 'random_image')
    .text('📂 Получить существующее', 'get_existing')
    
export async function showMainMenu(ctx: Context) {
  await ctx.reply("📋 Меню:", { reply_markup: mainMenu });
}

export async function switchMainMenu(ctx: Context) {
  await ctx.editMessageText("📋 Меню:", { reply_markup: mainMenu });
}