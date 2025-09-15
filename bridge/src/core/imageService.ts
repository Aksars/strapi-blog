import { InputFile } from 'grammy';
import path from 'path';
import fs from 'fs';
import { ImageGeneratorFactory } from './openAIGenerators.js';
import OpenAI from 'openai';
import { Context } from 'grammy';
import { formatFileSize } from '../utils/sizeFormater.js'



export class ImageService {
    constructor(private openAIClient: OpenAI) { }

    // Генерация изображения через AI
    async generateAIImage(ctx: Context, model: 'gpt' | 'dalle', prompt: string) {
        try {
            await ctx.reply(`🔄 Генерирую картинку моделью ${model}...`);

            const generator = ImageGeneratorFactory.createGenerator(model, this.openAIClient);
            const result = await generator.generate(prompt);

            if (!result) {
                await ctx.reply("⚠️ Не удалось сгенерировать картинку");
                return null;
            }

            await this.sendImage(ctx, result.buffer, result.filename,
                `🎨 ${model.toUpperCase()}: "${prompt}"`);

            await ctx.reply("✅ Готово! Используйте /menu для новых действий");
            return result;

        } catch (err) {
            console.error("Ошибка генерации:", err);
            await ctx.reply("⚠️ Ошибка при генерации картинки");
            throw err;
        }
    }

    // Отправка случайного изображения из папки
    async sendRandomImageFromFolder(ctx: Context, folderPath: string = "./images") {
        try {
            const files = fs.readdirSync(folderPath);

            if (!files.length) {
                await ctx.reply("⚠️ В папке images пока нет картинок.");
                return null;
            }

            const imageFiles = files.filter(file =>
                /\.(jpg|jpeg|png|gif|webp)$/i.test(file)
            );

            if (!imageFiles.length) {
                await ctx.reply("⚠️ В папке нет подходящих изображений.");
                return null;
            }

            const randomFile = imageFiles[Math.floor(Math.random() * imageFiles.length)];
            const filePath = path.join(folderPath, randomFile);

            const imageBuffer = fs.readFileSync(filePath);
            await this.sendImage(ctx, imageBuffer, randomFile, `🎲 Случайная картинка: ${randomFile}`);

            return randomFile;

        } catch (err) {
            console.error("Ошибка отправки изображения:", err);
            await ctx.reply("❌ Ошибка при отправке картинки.");
            throw err;
        }
    }

    // Универсальный метод отправки изображения
    private async sendImage(
        ctx: Context,
        imageBuffer: Buffer,
        filename: string,
        caption: string
    ) {
        await ctx.replyWithPhoto(
            new InputFile(imageBuffer, filename),
            { caption }
        );
    }

    // Дополнительные методы для работы с изображениями
    async getImageStats() {
        const imagesDir = "./images";
        if (!fs.existsSync(imagesDir)) {
            return { total: 0, files: [] };
        }

        const files = fs.readdirSync(imagesDir);
        const imageFiles = files.filter(file =>
            /\.(jpg|jpeg|png|gif|webp)$/i.test(file)
        );

        // Получаем информацию о файлах
        const imagesWithStats = imageFiles.map(file => {
            const filePath = path.join(imagesDir, file);
            const stats = fs.statSync(filePath);
            return {
                name: file,
                path: filePath,
                size: stats.size,
                sizeMB: formatFileSize(stats.size),
                createdAt: stats.birthtime
            };
        });

        const totalSize = imagesWithStats.reduce((sum, file) => sum + file.size, 0);
        const totalSizeMB = formatFileSize(totalSize)
        const avgSizeMB = formatFileSize(totalSize / imagesWithStats.length)
        const lastCreated = imagesWithStats.toSorted((a, b) => b.createdAt.getTime() - a.createdAt.getTime())[0].createdAt
        return {
            totalImages: imagesWithStats.length,
            totalSize,
            totalSizeMB,
            avgSizeMB,
            lastCreated,
            files: imagesWithStats
        };

    }

    // Валидация промпта для изображений
    validateImagePrompt(prompt: string): { isValid: boolean; message?: string } {
        if (!prompt || prompt.trim().length < 3) {
            return { isValid: false, message: "Промпт слишком короткий" };
        }

        if (prompt.length > 1000) {
            return { isValid: false, message: "Промпт слишком длинный" };
        }

        return { isValid: true };
    }
}


