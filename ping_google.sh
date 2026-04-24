#!/bin/bash

# Ping search engines о новых статьях
# Запуск: ./ping_google.sh

BASE_URL="https://polymer-consult.github.io"

echo "📢 Уведомляем поисковые системы..."

# Google (основной)
curl -s "http://www.google.com/ping?sitemap=$BASE_URL/sitemap.xml" && echo "✅ Google - уведомлен"
sleep 1

# Bing (тоже важен для EU)
curl -s "http://www.bing.com/ping?sitemap=$BASE_URL/sitemap.xml" && echo "✅ Bing - уведомлен"
sleep 1

# Yandex (если нужно для русскоязычных)
curl -s "http://blogs.yandex.ru/ping?sitemap=$BASE_URL/sitemap.xml" && echo "✅ Yandex - уведомлен"

echo ""
echo "🎯 Поисковики получили сигнал!"
echo "📝 Полная индексация займет 1-7 дней"
