import { getTokens, initRedisStorage, createBot, initOpenAI } from './init/index.js';
import { logger } from './utils/logger.js'
import { ImageGenerationService, ImageDeliveryService, StrapiService } from "./service/index.js";
import {
  setupCallbackHandlers, setupCommandHandlers,
  setupMessageHandlers, setupMiddlewareHandlers
} from './handlers/index.js';

// получаем и проверяем токены к боту и chatgpt
const { token, apiToken } = getTokens()

// Инициализируем редис хранилище, openAIClient, и телеграм бота
const openAIClient = initOpenAI(apiToken)
const storage = await initRedisStorage()
const bot = createBot(storage, token)
bot.start();
logger.info(" 🤖 Бот запущен и слушает сообщения!")

// Инициализируем классы для работы с страпи, отправки, и генерации изображений
const strapiService = new StrapiService()
const imageGenerationService = new ImageGenerationService(openAIClient);
const imageDeliveryService = new ImageDeliveryService(strapiService);

setupCallbackHandlers(bot, imageDeliveryService)
setupCommandHandlers(bot, imageDeliveryService)
setupMessageHandlers(bot, imageDeliveryService, imageGenerationService)
setupMiddlewareHandlers(bot)







