// services/strapiService.ts
import axios from 'axios';
import FormData from 'form-data';
import { Readable } from 'stream';
import { logger } from '../utils/logger.js';

export interface StrapiMedia {
  id: number;
  name: string;
  alternativeText: string;
  caption: string;
  width: number;
  height: number;
  formats: any;
  hash: string;
  ext: string;
  mime: string;
  size: number;
  url: string;
  previewUrl: string | null;
  provider: string;
  createdAt: string;
  updatedAt: string;
}

export class StrapiService {
  private baseURL: string;
  private token?: string;

  constructor() {
    this.baseURL = process.env.STRAPI_URL || 'http://strapi:1337';
    this.token = process.env.STRAPI_TOKEN;
    
    if (!this.token) {
      logger.warn('STRAPI_TOKEN не установлен. Загрузка в Strapi будет недоступна');
    }
  }

  async uploadImage(buffer: Buffer, filename: string, caption?: string): Promise<StrapiMedia | null> {
    if (!this.token) {
      logger.warn('Пропускаем загрузку в Strapi: токен не установлен');
      return null;
    }

    logger.info(`Будем грузить в страпи картинку, файлнейм ${filename} заголовок ${caption}`)

    try {
      const formData = new FormData();
      
      // Конвертируем Buffer в Stream для FormData
      const stream = Readable.from(buffer);
      formData.append('files', stream, {
        filename: filename,
        contentType: 'image/png'
      });

      formData.append('fileInfo', JSON.stringify({
        alternativeText: caption || filename,
        caption: caption || `Сгенерировано ботом: ${filename}`
      }));

      const response = await axios.post(
        `${this.baseURL}/api/upload`,
        formData,
        {
          headers: {
            'Authorization': `Bearer ${this.token}`,
            ...formData.getHeaders()
          },
          timeout: 30000
        }
      );
      logger.info(`Пришел респонс при загрузке по апи ${response}`)
      logger.info(`Изображение загружено в Strapi: ${response.data[0].name}`);
      return response.data[0];

    } catch (error) {
      logger.error('Ошибка загрузки в Strapi:', error);
      return null;
    }
  }

  async getMediaById(id: number): Promise<StrapiMedia | null> {
    try {
      const response = await axios.get(
        `${this.baseURL}/api/upload/files/${id}`,
        {
          headers: {
            'Authorization': `Bearer ${this.token}`
          }
        }
      );
      return response.data;
    } catch (error) {
      logger.error('Ошибка получения медиа из Strapi:', error);
      return null;
    }
  }
}