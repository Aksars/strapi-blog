// types/index.ts

// ⚡ Runtime (нужен на runtime)
export { MyContext, SessionStorage } from './session.js';

// ⚡ Только типы (TS проверяет, в JS не будет кода)
export type { 
  SessionData 
} from './session.js';

export type { 
  Image, 
  PoorImage, 
  ImageGenerationResult 
} from './image.js';

export { 
  TextModel, 
  ImageModel 
} from './models.js';