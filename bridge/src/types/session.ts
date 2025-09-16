import {SessionFlavor, Context} from 'grammy'
import { RedisAdapter } from '@grammyjs/storage-redis';
import { Image } from './index.js';
export type MyContext = Context & SessionFlavor<SessionData>;
export type SessionStorage = RedisAdapter<SessionData>;

export interface SessionData {
  state?: string;
  timestamp?: number;
  createdAt?: number;
  lastActivity?: number;
  // Новые поля для сложных состояний
  action?: string;
  model?: 'gpt' | 'dalle';
  saveToServer?: boolean;
  // Можно добавить любые другие данные
  tempData?: {
    prompt?: string;
    image?: Image;
  };
}