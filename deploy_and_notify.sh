#!/bin/bash

# MAIN DEPLOY SCRIPT - запускает все процессы
# Использование: ./deploy_and_notify.sh

echo "🚀 НАЧИНАЕМ ПРОДВИЖЕНИЕ"
echo "========================"
echo ""

# 1. Добавляем гео-теги
echo "📍 Шаг 1: Добавление гео-тегов"
./add_geo_tags.sh
echo ""

# 2. Генерируем sitemap
echo "🗺️ Шаг 2: Генерация sitemap.xml"
./generate_sitemap.sh
echo ""

# 3. Обновляем временные метки
echo "🕒 Шаг 3: Обновление временных меток"
./update_timestamps.sh
echo ""

# 4. Коммитим изменения
echo "💾 Шаг 4: Сохранение в git"
git add .
git commit -m "SEO update: Geo tags and sitemap $(date +%Y-%m-%d)"
echo ""

# 5. Пушим на GitHub
echo "📤 Шаг 5: Отправка на GitHub"
git push origin main
echo ""

# 6. Нотифицируем Google
echo "📢 Шаг 6: Уведомление поисковиков"
./ping_google.sh
echo ""

echo "========================"
echo "✅ ВСЕ ГОТОВО!"
echo "🌍 Google получил сигнал о $SITE_URL"
echo "📊 Индексация начнется в ближайшие часы"
