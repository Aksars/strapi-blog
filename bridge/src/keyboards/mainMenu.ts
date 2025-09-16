import { InlineKeyboard } from 'grammy';

export const mainMenu = new InlineKeyboard()
  .text("🖼 Сгенерировать картинку (GPT)", "generate_gpt")
  .text("🎨 Сгенерировать картинку (Dalle)", "generate_dalle")
  .row()
  .text("🎲 Случайная картинка", "random_image")
  .text("📝 Сгенерировать текст", "generate_text");