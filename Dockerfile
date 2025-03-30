FROM composer:2 as builder

WORKDIR /app

# Установка зависимостей
COPY app/composer.json app/composer.lock ./
RUN composer install --no-dev --no-scripts --no-autoloader --ignore-platform-reqs

# Копирование всего проекта
COPY app/ .

# Оптимизация автозагрузки

RUN composer dump-autoload --optimize && \
    composer run-script post-install-cmd && \
    mkdir -p bootstrap/cache storage

# Этап 2: Запуск
FROM php:8.1-apache

WORKDIR /var/www/html

# Установка системных зависимостей
RUN apt-get update && apt-get install -y \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    libicu-dev \
    zip \
    unzip \
    git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd pdo_mysql zip mbstring exif pcntl bcmath intl opcache

# Настройка Apache
RUN a2enmod rewrite headers

# Копирование собранного приложения
COPY --from=builder /app /var/www/html
COPY --from=builder /usr/bin/composer /usr/bin/composer

# Создание отсутствующих директорий
RUN mkdir -p /var/www/html/bootstrap/cache && \
    mkdir -p /var/www/html/storage && \
    mkdir -p /var/www/html/storage/framework/{cache,sessions,views} && \
    mkdir -p /var/www/html/storage/logs

# Установка прав
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 775 /var/www/html/storage && \
    chmod -R 775 /var/www/html/bootstrap/cache

# Переменные окружения
ENV APP_ENV=production
ENV APP_DEBUG=false
ENV APP_KEY=
ENV APP_URL=http://localhost
ENV DB_CONNECTION=mysql
ENV DB_HOST=db
ENV DB_PORT=3306
ENV DB_DATABASE=winter
ENV DB_USERNAME=winter
ENV DB_PASSWORD=winter
ENV CACHE_DRIVER=file
ENV SESSION_DRIVER=file
ENV QUEUE_DRIVER=sync

# Открытие порта
EXPOSE 80

# Скрипт запуска
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["apache2-foreground"]