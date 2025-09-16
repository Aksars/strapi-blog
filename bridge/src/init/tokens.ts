// import 'dotenv/config'; докер сам подтягивает энвы в процесс, можно не делать

export function getTokens() {
    
    // --- Проверка токена ---
    const token = process.env.BOT_TOKEN;
    if (!token) {
        console.error("❌ BOT_TOKEN не задан в .env");
        process.exit(1);
    }

    const apiToken = process.env.OPENAI_API_KEY;
    if (!apiToken) {
        console.error("❌ OPENAI_API_KEY не задан в .env");
        process.exit(1);
    }

    return { token, apiToken }
}