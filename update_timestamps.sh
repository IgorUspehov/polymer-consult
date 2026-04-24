#!/bin/bash

# Обновление временных меток для стимуляции переиндексации
# Запуск: ./update_timestamps.sh

CURRENT_DATE=$(date +%Y-%m-%d)
CURRENT_TIME=$(date +%H:%M:%S)

echo "🕒 Обновляем временные метки во всех HTML файлах..."

find . -name "*.html" -type f | while read file; do
    # Пропускаем бэкапы
    if [[ "$file" != *".bak"* ]] && [[ "$file" != *"backup"* ]]; then
        # Добавляем или обновляем comment с датой
        if grep -q "Last updated" "$file"; then
            sed -i "s/Last updated: .*/Last updated: $CURRENT_DATE $CURRENT_TIME/" "$file"
        else
            # Добавляем перед </body>
            sed -i "s/<\/body>/<!-- Last updated: $CURRENT_DATE $CURRENT_TIME -->\n<\/body>/" "$file"
        fi
        echo "✓ $file"
    fi
done

echo "✅ Готово! Все даты обновлены на $CURRENT_DATE"
