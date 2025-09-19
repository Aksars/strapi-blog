
import { saveMenu, } from './saveMenu.js';
import { imageModelMenu } from './imageModelMenu.js';
import { textModelMenu, } from './textModelMenu.js';
import { strapiMenu, } from './strapiMenu.js';
import { mainMenu, showMainMenu } from './mainMenu.js';
export { strapiMenu, showMainMenu, saveMenu, imageModelMenu, textModelMenu, }


import { InlineKeyboard } from 'grammy';
import { MyContext } from '../types/session.js';
import { ImageModel, TextModel } from '../types/models.js';




// Главное меню
export async function switchMainMenu(ctx: MyContext) {


  await ctx.editMessageText(
    "📋 Меню:",
    {
      reply_markup: mainMenu,
      parse_mode: 'Markdown'
    }
  );
}

// Меню выбора текстовой модели
export async function showTextModelMenu(ctx: MyContext) {
  const keyboard = new InlineKeyboard()
    .text('GPT-3.5 Turbo', 'text_model_gpt35')
    .text('GPT-4', 'text_model_gpt4')
    .text('GPT-4 Turbo', 'text_model_gpt4turbo')
    .row()
    .text('↩️ Назад', 'menu');

  await ctx.editMessageText(
    '🧠 **Выберите текстовую модель:**\n\n' +
    '• *GPT-3.5 Turbo* - быстрая и экономичная\n' +
    '• *GPT-4* - более умная и точная\n' +
    '• *GPT-4 Turbo* - оптимальная по скорости и качеству',
    {
      reply_markup: keyboard,
      parse_mode: 'Markdown'
    }
  );
}

// Меню выбора модели изображений
export async function showImageModelMenu(ctx: MyContext) {
  const keyboard = new InlineKeyboard()
    .text('GPT Image', 'image_model_gpt')
    .text('DALL-E', 'image_model_dalle')
    .row()
    .text('↩️ Назад', 'menu');

  await ctx.editMessageText(
    '🎨 **Выберите модель для генерации изображений:**\n\n' +
    '• *GPT Image-1* - обычная современная модель\n' +
    '• *DALL-E-2* - иногда выдает более качественный результат, хотя старая',
    {
      reply_markup: keyboard,
      parse_mode: 'Markdown'
    }
  );
}

// Действия после генерации текста
export async function showTextActions(ctx: MyContext) {
  const keyboard = new InlineKeyboard()
    .text('🔄 Регенерировать', 'regenerate_text')
    .text('📝 Новый текст', 'new_text')
    .row()
    .text('📋 Главное меню', 'menu');

  await ctx.reply(
    '✅ **Генерация завершена!**\n\n' +
    'Что дальше?\n' +
    '• 🔄 Регенерировать текст\n' +
    '• 📝 Новый запрос\n' +
    '• 📋 Главное меню',
    {
      reply_markup: keyboard,
      parse_mode: 'Markdown'
    }
  );
}

// Действия после генерации изображения
export async function showImageActions(ctx: MyContext) {
  const keyboard = new InlineKeyboard()
    .text('💾 Сохранить на сервер', 'save_yes')
    .text('❌ Не сохранять', 'save_no');

  await ctx.reply(
    '🎨 **Изображение сгенерировано!**\n\n' +
    'Сохранить изображение на сервер?',
    {
      reply_markup: keyboard,
      parse_mode: 'Markdown'
    }
  );
}

// Меню сохранения в Strapi (остается без изменений)
export async function showStrapiMenu(ctx: MyContext) {
  const keyboard = new InlineKeyboard()
    .text('✅ Отправить в Strapi', 'strapi_yes')
    .text('❌ Не отправлять', 'strapi_no');

  await ctx.editMessageText(
    '🚀 **Отправить изображение в Strapi?**',
    { reply_markup: keyboard }
  );
}

// Меню сохранения на сервер (остается без изменений)
export async function showSaveMenu(ctx: MyContext) {
  const keyboard = new InlineKeyboard()
    .text('💾 Сохранить на сервер', 'save_yes')
    .text('❌ Не сохранять', 'save_no');

  await ctx.editMessageText(
    '💾 **Сохранить изображение на сервер?**',
    { reply_markup: keyboard }
  );
}

export async function madnessMenu(ctx: MyContext) {
  const keyboard = new InlineKeyboard()
    .text('↩️ Назад', 'menu');
  await ctx.editMessageText(
    'Введите уровень безумия от 1 до 10',
    { reply_markup: keyboard }
  );
}