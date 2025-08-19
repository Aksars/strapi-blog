#!/bin/bash

# Функция для генерации случайного ключа (32 байта в base64)
generate_key() {
    openssl rand -base64 32 | tr -d '\n'
}

# Функция для генерации случайного пароля (16 символов)
generate_password() {
    openssl rand -base64 12 | tr -d '/+=' | cut -c1-16
}

# 1. Обрабатываем .env.db
echo "Создание .env.db..."
cat > .env.db << EOF
POSTGRES_USER=strapi
POSTGRES_PASSWORD=$(generate_password)
POSTGRES_DB=strapi_db
DATABASE_USERNAME=strapi
DATABASE_PASSWORD=$(generate_password)
DATABASE_NAME=strapi_db
DATABASE_SSL=false
EOF

# 2. Обрабатываем .env.nextjs (просто копируем шаблон)
echo "Создание .env.nextjs..."
cat > .env.nextjs << EOF
NEXT_PUBLIC_STRAPI_API_URL=http://strapi:1337
EOF

# 3. Обрабатываем .env.strapi
echo "Создание .env.strapi с секретными ключами..."
cat > .env.strapi << EOF
# Server
HOST=0.0.0.0
PORT=1337

# Secrets
APP_KEYS=$(generate_key),$(generate_key),$(generate_key),$(generate_key)
API_TOKEN_SALT=$(generate_key)
ADMIN_JWT_SECRET=$(generate_key)
TRANSFER_TOKEN_SALT=$(generate_key)
ENCRYPTION_KEY=$(generate_key)
JWT_SECRET=$(generate_key)
EOF

# 4. Удаляем старые файлы примеров
echo "Удаление старых example файлов..."
rm -f .example.env.db .example.env.nextjs .example.env.strapi

# 5. Удаляем самого себя
echo "Готово! Все .env файлы созданы."
echo "Удаляю setup.sh..."
rm -- "$0"