#!/bin/bash

# Генератор sitemap.xml для Google
# Запуск: ./generate_sitemap.sh

SITEMAP="sitemap.xml"
BASE_URL="https://polymer-consult.github.io"  # Замени на свой URL
LAST_MOD=$(date +%Y-%m-%d)

# Начинаем sitemap
cat > "$SITEMAP" << 'XMLHEADER'
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
        xmlns:xhtml="http://www.w3.org/1999/xhtml">
XMLHEADER

# Добавляем все HTML файлы
find . -name "*.html" -type f | while read file; do
    # Убираем ./ из начала
    clean_file="${file#./}"
    
    # Пропускаем backup файлы
    if [[ "$clean_file" != *".bak"* ]]; then
        echo "  <url>" >> "$SITEMAP"
        echo "    <loc>$BASE_URL/$clean_file</loc>" >> "$SITEMAP"
        echo "    <lastmod>$LAST_MOD</lastmod>" >> "$SITEMAP"
        echo "    <changefreq>weekly</changefreq>" >> "$SITEMAP"
        echo "    <priority>0.8</priority>" >> "$SITEMAP"
        
        # Добавляем hreflang альтернативы
        base_name=$(basename "$clean_file" .html)
        dir_name=$(dirname "$clean_file")
        
        echo "    <xhtml:link rel=\"alternate\" hreflang=\"de\" href=\"$BASE_URL/de/$base_name.html\"/>" >> "$SITEMAP"
        echo "    <xhtml:link rel=\"alternate\" hreflang=\"en\" href=\"$BASE_URL/en/$base_name.html\"/>" >> "$SITEMAP"
        echo "    <xhtml:link rel=\"alternate\" hreflang=\"ru\" href=\"$BASE_URL/ru/$base_name.html\"/>" >> "$SITEMAP"
        
        echo "  </url>" >> "$SITEMAP"
    fi
done

# Закрываем sitemap
echo "</urlset>" >> "$SITEMAP"

echo "✅ Sitemap создан: $SITEMAP"
echo "📊 Найдено URL: $(grep -c "<loc>" "$SITEMAP")"

# Проверяем валидность
if command -v xmllint &> /dev/null; then
    xmllint --noout "$SITEMAP" && echo "✅ Sitemap валиден"
else
    echo "⚠️ Установи xmllint для проверки: sudo apt install libxml2-utils"
fi
