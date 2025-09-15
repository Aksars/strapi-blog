export interface SessionData {
    state?: 'waiting_gpt_prompt' | 'waiting_dalle_prompt' | 'idle' | 'generate_to_strapi';
    timestamp?: number;
    createdAt: number;
    lastActivity: number;
}