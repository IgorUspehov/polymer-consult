#!/bin/bash

# Скрипт для добавления гео-тегов в HTML статьи
# Использование: ./add_geo_tags.sh

# Определяем целевую страну (можно менять)
TARGET_COUNTRY="DE"  # Германия
TARGET_REGION="DE-BY" # Бавария

# Проходим по всем HTML файлам
for file in $(find . -name "*.html" -type f); do
    echo "Обработка: $file"
    
    # Делаем бэкап
    cp "$file" "$file.bak"
    
    # Проверяем, есть ли уже geo-теги
    if ! grep -q "geo.region" "$file"; then
        # Добавляем geo-теги после <head>
        sed -i 's/<head>/<head>\n    <!-- GEO TARGETING FOR GERMANY -->\n    <meta name="geo.region" content="'$TARGET_COUNTRY'" \/>\n    <meta name="geo.placename" content="Germany" \/>\n    <meta name="geo.position" content="51.1657;10.4515" \/>\n    <meta name="ICBM" content="51.1657, 10.4515" \/>\n    <link rel="alternate" hreflang="x-default" href="https:\/\/polymer-consult.github.io\/en\/$(basename "$file")" \/>\n    <!-- END GEO TAGS -->/' "$file"
    fi
    
    # Проверяем language attribute
    if ! grep -q "lang=" "$file"; then
        # Определяем язык по имени файла или папке
        if [[ "$file" == *"de.html" ]] || [[ "$file" == *"/de/"* ]]; then
            sed -i 's/<html/<html lang="de"/' "$file"
        elif [[ "$file" == *"en.html" ]] || [[ "$file" == *"/en/"* ]]; then
            sed -i 's/<html/<html lang="en"/' "$file"
        elif [[ "$file" == *"ru.html" ]] || [[ "$file" == *"/ru/"* ]]; then
            sed -i 's/<html/<html lang="ru"/' "$file"
        fi
    fi
    
    echo "✅ Обработан: $file"
done

echo "🎯 Готово! Geo-теги добавлены во все HTML файлы"
