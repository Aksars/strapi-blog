import StrapiService from "./strapiService.js";
import { ImageGenerationService }  from "./imageGenerationService.js";
import { TextGenerationService } from "./textGenerationService.js";
import ImageDeliveryService from "./imageDeliveryService.js";
import FileImageService from "./fileImageService.js";

// Экспортируем типы отдельно
export type { ImageGenerationResult } from "./imageGenerationService.js";


export {
    StrapiService,    
    ImageGenerationService,
    ImageDeliveryService,
    TextGenerationService,
    FileImageService
}