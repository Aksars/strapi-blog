export interface Image {
  buffer: Buffer;
  filename: string;
  prompt?: string;
  model?: string;
  createdAt?: Date;
  size?: number;
}

export type PoorImage = Pick<Image, 'buffer' | 'filename' | 'size'>;

export interface ImageGenerationResult {
  success: boolean;
  image?: Image;
  error?: string;
}