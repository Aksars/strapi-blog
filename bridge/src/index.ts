import { getTokens, initRedisStorage, createBot, initOpenAI } from './init/index.js';
import { logger } from './utils/logger.js'
import { ImageGenerationService, ImageDeliveryService, TextGenerationService, StrapiService } from "./service/index.js";
import {
  setupCallbackHandlers, setupCommandHandlers,
  setupMessageHandlers, setupMiddlewareHandlers
} from './handlers/index.js';

async function main() {
  try {
    const { token, apiToken } = getTokens();

    // Инициализируем основные зависимости
    const openAIClient = initOpenAI(apiToken);
    const storage = await initRedisStorage();
    const bot = createBot(storage, token);

    // Инициализируем сервисы
    const strapiService = new StrapiService();
    const imageGenerationService = new ImageGenerationService(openAIClient);
    const imageDeliveryService = new ImageDeliveryService(strapiService);
    const textGenerationService = new TextGenerationService(openAIClient)
    // Настраиваем обработчики
    setupCallbackHandlers(bot, imageDeliveryService, imageGenerationService, textGenerationService, strapiService);
    setupCommandHandlers(bot, imageDeliveryService, imageGenerationService);
    setupMessageHandlers(bot, imageDeliveryService, imageGenerationService, textGenerationService, strapiService);
    setupMiddlewareHandlers(bot);

    // Запускаем ботаasdasd
    bot.start();
    logger.info(" 🤖 Бот запущен и слушает сообщения!");

  } catch (error) {
    logger.error("❌ Критическая ошибка при запуске бота:", error);
    process.exit(1);
  }
}

main();