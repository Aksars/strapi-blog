// --- Инициализация OpenAI ---
import OpenAI from "openai";

export function initOpenAI(apiToken:string){
 const client = new OpenAI({
  apiKey: apiToken,
});
return client
}


