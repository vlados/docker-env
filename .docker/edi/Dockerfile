# external-api/Dockerfile

FROM php:8.0-fpm-alpine

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
    linux-headers

# Install PHP extensions
RUN docker-php-ext-install \
    pdo_mysql \
    intl \
    zip \
    gd \
    opcache \
    mbstring \
    exif

# Install Xdebug conditionally
ARG XDEBUG=false
RUN if [ $XDEBUG = "true" ]; then \
        apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
        && pecl install xdebug \
        && docker-php-ext-enable xdebug \
        && apk del .build-deps; \
    fi

RUN apk update && \
    apk add zsh git nano zsh-autosuggestions zsh-syntax-highlighting bind-tools curl && \
    rm -rf /var/cache/apk/*
RUN sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
RUN echo "source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc && \
echo "source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc

WORKDIR /var/www/edi
