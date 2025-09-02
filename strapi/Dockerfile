# Базовый образ с Node.js 20 (Alpine - минимальная версия)
FROM node:20-alpine

# Устанавливаем ТОЛЬКО необходимые системные зависимости
RUN apk add --no-cache python3 make g++ vips-dev curl

# Создаем и переходим в рабочую директорию
WORKDIR /app

# Копируем ТОЛЬКО файлы зависимостей сначала
COPY package.json ./

# Устанавливаем зависимости с флагами для Strapi
RUN npm install --legacy-peer-deps --force
RUN npm install pm2-runtime 

# Не стоит так делать, лучше в докер компоузе команды писать иначе пересобирать прийдется
# CMD ["npm", "run", "develop"]
# CMD ["tail", "-f", "/dev/null"]   

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]