#!/bin/bash

docker-entrypoint.sh apache2-foreground &
sleep 7
# Проверка на наличие WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
wp core install --url=localhost --title="${WP_TITLE}" --admin_user=${WP_ADMIN_USER} --admin_password="${WP_ADMIN_PASSWORD}" --admin_email=test@test.com --allow-root

echo "Установка плагина Redis..."
wp plugin install redis-cache --activate --allow-root

# Включение Redis
echo "Включение Redis..."
wp redis enable --allow-root

echo "Настройка завершена!"
wait