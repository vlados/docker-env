FROM php:8.1-fpm

RUN apt-get update && apt-get install -y \
    libonig-dev \
    libzip-dev \
    zip \
    unzip \
    git \
    && docker-php-ext-install pdo_mysql zip \
    && pecl install redis \
    && docker-php-ext-enable redis opcache

WORKDIR /var/www/html

COPY ./app /var/www/html

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN chown -R www-data:www-data /var/www/html

ENV PHP_OPCACHE=true \
    PHP_DISPLAY_ERRORS=true \
    PHP_ERROR_REPORTING=E_ALL

RUN if [ "$PHP_OPCACHE_ENABLE" = "true" ]; then \
      echo "opcache.enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini && \
      echo "opcache.enable_cli=1" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini; \
    fi

RUN if [ "$PHP_DISPLAY_ERRORS" = "true" ]; then \
      echo "display_errors=1" >> /usr/local/etc/php/conf.d/docker-php-ext-errors.ini && \
      echo "error_reporting=$PHP_ERROR_REPORTING" >> /usr/local/etc/php/conf.d/docker-php-ext-errors.ini; \
    fi

EXPOSE 9000

CMD ["php-fpm"]

