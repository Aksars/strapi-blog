import {SessionFlavor, Context} from 'grammy'
import { RedisAdapter } from '@grammyjs/storage-redis';
import { Image } from './index.js';
import { TextModel, ImageModel } from './models.js';

export type MyContext = Context & SessionFlavor<SessionData>;
export type SessionStorage = RedisAdapter<SessionData>;

export interface SessionData {
  state?: string;
  timestamp?: number;
  createdAt?: number;
  lastActivity?: number;
  // Новые поля для сложных состояний
  action?: string;
  imageModel?: ImageModel
  textModel?: TextModel
  temperature?:number
  saveToServer?: boolean;
  sendToStrapi?:boolean;  
  generationType?: 'text' | 'image' | 'existing'; 
  tempData?: {
    prompt?: string;
    image?: Image;
    generatedText?: string;
  };
}