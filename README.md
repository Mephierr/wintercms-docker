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