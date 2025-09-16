import fs from 'fs';
import path from 'path';
import { formatFileSize } from '../utils/sizeFormater.js';
import type { Image } from './imageGenerationService.js';

export default class FileImageService {
  // Сохранение изображения в папку
  static saveImage(image: Image, folderPath: string = "./images"): boolean {
    try {
      if (!fs.existsSync(folderPath)) {
        fs.mkdirSync(folderPath, { recursive: true });
      }

      const filepath = path.join(folderPath, image.filename);
      fs.writeFileSync(filepath, image.buffer);

      return true;
    } catch (error) {
      console.error("Ошибка сохранения изображения:", error);
      return false;
    }
  }

  // Получение случайного изображения из папки
  static getRandomImage(folderPath: string = "./images"): Image | null {
    try {
      const files = fs.readdirSync(folderPath);

      if (!files.length) {
        return null;
      }

      const imageFiles = files.filter(file =>
        /\.(jpg|jpeg|png|gif|webp)$/i.test(file)
      );

      if (!imageFiles.length) {
        return null;
      }

      const randomFile = imageFiles[Math.floor(Math.random() * imageFiles.length)];
      const filePath = path.join(folderPath, randomFile);

      const buffer = fs.readFileSync(filePath);
      const stats = fs.statSync(filePath);

      return {
        buffer,
        filename: randomFile,
        prompt: '', // Не знаем промпт для существующих файлов
        model: 'unknown',
        size: stats.size
      };

    } catch (error) {
      console.error("Ошибка чтения изображения:", error);
      return null;
    }
  }

  // Получение статистики изображений
  static getImageStats(folderPath: string = "./images") {
    if (!fs.existsSync(folderPath)) {
      return {
        totalImages: 0,
        totalSize: 0,
        totalSizeMB: '0 MB',
        avgSizeMB: '0 MB',
        lastCreated: undefined,  // ✅ Явно указываем undefined
        files: []
      };
    }

    const files = fs.readdirSync(folderPath);
    const imageFiles = files.filter(file =>
      /\.(jpg|jpeg|png|gif|webp)$/i.test(file)
    );

    if (imageFiles.length === 0) {
      return {
        totalImages: 0,
        totalSize: 0,
        totalSizeMB: '0 MB',
        avgSizeMB: '0 MB',
        lastCreated: undefined,  // ✅ Явно указываем undefined
        files: []
      };
    }

    const imagesWithStats = imageFiles.map(file => {
      const filePath = path.join(folderPath, file);
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
    const sortedByDate = imagesWithStats.sort((a, b) =>
      b.createdAt.getTime() - a.createdAt.getTime()
    );

    return {
      totalImages: imagesWithStats.length,
      totalSize,
      totalSizeMB: formatFileSize(totalSize),
      avgSizeMB: formatFileSize(totalSize / imagesWithStats.length),
      lastCreated: sortedByDate[0]?.createdAt,  // ✅ Безопасное получение
      files: imagesWithStats
    };
  }
}