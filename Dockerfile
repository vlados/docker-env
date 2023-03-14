FROM php:8.1-fpm as build
WORKDIR /app
COPY . .
ENV COMPOSER_ALLOW_SUPERUSER=1
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# RUN composer install --no-dev --prefer-dist --optimize-autoloader

FROM php:8.1-fpm-alpine
WORKDIR /app
COPY --from=build /app .

