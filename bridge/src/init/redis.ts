import { Redis } from "ioredis";
import { RedisAdapter } from "@grammyjs/storage-redis";
import { SessionData } from "../types/session.js"; // ← импорт типа

export async function initRedisStorage() {

    const redis = new Redis({
        host: "redis", // 👈 имя контейнера из docker-compose
        port: 6379,
    });

    // Обработка ошибок подключения
    redis.on('error', (err) => {
        console.error('❌ Redis error:', err);
    });

    redis.on('connect', () => {
        console.log('✅ Connected to Redis');
    });

    try {
        // Таймаут 2 секунды на подключение
        const start = Date.now()
        const pong = await Promise.race([
            redis.ping(),
            new Promise((_, reject) =>
                setTimeout(() => reject(new Error('Redis timeout')), 2000)
            )
        ]);
        console.log(`✅ Redis available: ${pong} in ${Date.now() - start}ms`);
    } catch (error) {
        console.error('❌ Redis error:', error);
    }

    const storage = new RedisAdapter<SessionData>({
        instance: redis, // ← Передаем инстанс
        ttl: 60 * 60 * 24, // Опционально: время жизни в секундах (24 часа)
    });

    return storage
}
