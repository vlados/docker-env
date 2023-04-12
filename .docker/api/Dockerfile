# api/Dockerfile

FROM php:7.4-fpm-alpine

# Install required system packages
RUN apk update && apk add --no-cache \
    git \
    unzip \
    libzip-dev \
    icu-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    zlib-dev \
    libxml2-dev \
    oniguruma-dev \
    linux-headers \
    gettext-dev \
    bash

# Install PHP extensions
RUN docker-php-ext-install \
    pdo_mysql \
    intl \
    zip \
    gd \
    opcache \
    mbstring \
    exif \
    bcmath \
    mbstring \
    zip \
    pcntl \
    gettext \
    exif \
    sockets

RUN apk --no-cache add pcre-dev ${PHPIZE_DEPS} \
  && pecl install redis \
  && docker-php-ext-enable redis \
  && apk del pcre-dev ${PHPIZE_DEPS}

# Install Xdebug conditionally
ARG XDEBUG=false
RUN if [ $XDEBUG = "true" ]; then \
        apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
        && pecl install xdebug-2.9.8 \
        && docker-php-ext-enable xdebug \
        && apk del .build-deps; \
    fi

COPY api.pool.conf /usr/local/etc/php-fpm.d/www.conf
COPY php.ini /usr/local/etc/php/conf.d/php.ini

# Set working directory
WORKDIR /var/www/api

RUN apk update && \
    apk add zsh git nano zsh-autosuggestions zsh-syntax-highlighting bind-tools curl && \
    rm -rf /var/cache/apk/*
RUN sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
RUN echo "source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc && \
echo "source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc

ARG UID
ARG GID

ENV UID=${UID}
ENV GID=${GID}

RUN addgroup -g ${GID} --system symfony
RUN adduser -G symfony --system -D -s /bin/sh -u ${UID} symfony
RUN chown -R symfony:symfony /var/www/api
