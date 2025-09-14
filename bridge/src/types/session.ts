export interface SessionData {
    state?: 'waiting_gpt_prompt' | 'waiting_dalle_prompt' | 'idle';
    timestamp?: number;
    createdAt: number;
    lastActivity: number;
}