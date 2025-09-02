#!/bin/sh
# Запускаем strapi под pm2 в фоне
npx pm2-runtime start npm --name strapi -- run develop

# Держим контейнер живым
exec tail -f /dev/null
