import axios, { AxiosInstance } from 'axios';
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

export interface StrapiServiceConfig {
  baseURL?: string;
  token?: string;
  timeout?: number;
}

export default class StrapiService {
  private readonly client: AxiosInstance;
  private readonly config: StrapiServiceConfig;

  constructor(config: StrapiServiceConfig = {}) {
    this.config = {
      baseURL: process.env.STRAPI_URL || 'http://strapi:1337',
      token: process.env.STRAPI_TOKEN,
      timeout: 30000,
      ...config
    };

    if (!this.config.token) {
      logger.warn('STRAPI_TOKEN не установлен. Загрузка в Strapi будет недоступна');
    }

    this.client = axios.create({
      baseURL: this.config.baseURL,
      timeout: this.config.timeout,
      headers: {
        'Authorization': this.config.token ? `Bearer ${this.config.token}` : undefined
      }
    });
  }

  async uploadImage(buffer: Buffer, filename: string, caption?: string): Promise<StrapiMedia | null> {
    if (!this.config.token) {
      logger.warn('Пропускаем загрузку в Strapi: токен не установлен');
      return null;
    }

    logger.info(`Загрузка в Strapi: ${filename}, заголовок: ${caption}`);

    try {
      const formData = new FormData();
      
      const stream = Readable.from(buffer);
      formData.append('files', stream, {
        filename: filename,
        contentType: 'image/png'
      });

      formData.append('fileInfo', JSON.stringify({
        alternativeText: caption || filename,
        caption: caption || `Сгенерировано ботом: ${filename}`
      }));

      const response = await this.client.post(
        '/api/upload',
        formData,
        {
          headers: {
            ...formData.getHeaders()
          }
        }
      );

      logger.info(`Изображение загружено в Strapi: ${response.data[0].name}`);
      return response.data[0];

    } catch (error) {
      logger.error('Ошибка загрузки в Strapi:', error);
      return null;
    }
  }

  async getMediaById(id: number): Promise<StrapiMedia | null> {
    if (!this.config.token) {
      return null;
    }

    try {
      const response = await this.client.get(`/api/upload/files/${id}`);
      return response.data;
    } catch (error) {
      logger.error('Ошибка получения медиа из Strapi:', error);
      return null;
    }
  }

  // Дополнительные полезные методы
  async deleteMedia(id: number): Promise<boolean> {
    try {
      await this.client.delete(`/api/upload/files/${id}`);
      return true;
    } catch (error) {
      logger.error('Ошибка удаления медиа из Strapi:', error);
      return false;
    }
  }

  async getMediaList(): Promise<StrapiMedia[]> {
    try {
      const response = await this.client.get('/api/upload/files');
      return response.data;
    } catch (error) {
      logger.error('Ошибка получения списка медиа из Strapi:', error);
      return [];
    }
  }
}