#!/bin/sh
# Запускаем next
npx pm2-runtime start npm --name nextjs -- run dev

# Держим контейнер живым
exec tail -f /dev/null
