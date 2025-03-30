#!/bin/sh

set -e

if [ -z "$APP_KEY" ]; then
  echo "ОШИБКА: APP_KEY не установлен. Пожалуйста, задайте действительный ключ."
  echo "Вы можете сгенерировать его командой 'php artisan key:generate --show'"
  exit 1
fi

# Ожидание готовности БД
echo "Ожидание подключения к базе данных..."
while ! nc -z $DB_HOST $DB_PORT; do
  sleep 1
done
echo "База данных готова!"

# Выполнение миграций и установки Winter
php artisan winter:up

exec "$@"