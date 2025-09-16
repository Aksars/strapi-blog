export interface Image {
  buffer: Buffer;
  filename: string;
  prompt?: string;
  model?: string;
  createdAt?: Date;
  size?: number;
}

export interface ImageGenerationResult {
  success: boolean;
  image?: Image;
  error?: string;
}