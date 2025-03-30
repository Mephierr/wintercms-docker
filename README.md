# Winter CMS - Docker развертывание

![Winter CMS Logo](https://wintercms.com/images/winter-logo.svg)

Полная Docker-конфигурация для Winter CMS с поддержкой MySQL, Composer и Node.js.

## Содержание
- [Возможности](#возможности)
- [Требования](#требования)
- [Быстрый старт](#быстрый-старт)
- [Конфигурация](#конфигурация)
- [Структура проекта](#структура-проекта)
- [Основные команды](#основные-команды)
- [Решение проблем](#решение-проблем)
- [Продуктовое окружение](#продуктовое-окружение)
- [Разработка](#разработка)
- [Лицензия](#лицензия)

## Возможности

- 🐳 Готовое Docker-окружение
- 🛠️ Включает MySQL, Composer и Node.js
- 🔄 Горячая перезагрузка для разработки
- 🔒 Безопасная конфигурация по умолчанию
- 📦 Оптимизированная сборка для production

## Требования

- Docker 20.10+
- Docker Compose 2.0+
- Git
- 2GB+ свободной оперативной памяти

## Быстрый старт

```bash
# Клонировать репозиторий
git clone https://github.com/ваш-username/wintercms-docker.git
cd wintercms-docker

# Запустить контейнеры
docker-compose up -d --build

# Установить зависимости
docker-compose exec app composer install

# Сгенерировать ключ приложения
docker-compose exec app php artisan key:generate

# Запустить установщик Winter CMS
docker-compose exec app php artisan winter:install
```
Доступ к сайту:

    Фронтенд: http://localhost:8080

    Админка: http://localhost:8080/backend

## Конфигурация

Измените файл .env:
```bash
APP_NAME=WinterCMS
APP_ENV=local
APP_KEY=base64:ваш-сгенерированный-ключ
APP_URL=http://localhost:8080

DB_HOST=db
DB_DATABASE=winter
DB_USERNAME=winter
DB_PASSWORD=winter
```
## Структура проекта

```bash
├── app/                  # Приложение Winter CMS
│   ├── bootstrap/        # Файлы фреймворка
│   ├── config/           # Конфигурационные файлы
│   ├── storage/          # Директория для хранения данных
│   └── artisan           # Исполняемый файл консоли
├── Dockerfile            # Конфигурация PHP/Apache
├── entrypoint.sh         # Скрипт запуска    
├── .env                  # Переменные окружения
└── docker-compose.yml    # Определения сервисов
```

## Основные команды
```bash
docker-compose up -d	Запуск контейнеров
docker-compose down	Остановка контейнеров
docker-compose exec app php artisan migrate	Выполнить миграции
docker-compose exec app composer update	Обновить зависимости
docker-compose logs -f app	Просмотр логов приложения
```

## Решение проблем

Отсутствуют vendor-файлы:
```bash

docker-compose exec app composer install
```
Проблемы с правами:
```bash
docker-compose exec app chown -R www-data:www-data /var/www/html/storage
```

Проблемы с подключением к БД:
```bash

docker-compose restart db
```

## Разработка

Для внесения изменений:

    Создайте ветку для новой фичи:

```bash
git checkout -b feature/новая-фича
```

    Сделайте коммит изменений:

```bash
git commit -m "Добавлена новая фича"
```
    Запушьте изменения в ветку:

```bash
git push origin feature/новая-фича
```
    Откройте pull request

## Лицензия

Этот проект распространяется под лицензией MIT.