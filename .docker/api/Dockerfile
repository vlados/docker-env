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
    mysql-client \
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
  && pecl install redis-3.1.6 \
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

# Enviorment variables (needed for bin/console commands)
ENV LOCALTIME ${TIMEZONE}
ENV MYFM__MAILER__USER user
ENV MYFM__MAILER__PASSWORD pass

ENV MYFM__ENV                dev
ENV MYFM__DATABASE__HOST     mysql
ENV MYFM__DATABASE__PORT     3306
ENV MYFM__MAIL__BASE__URL http://localhost:89

ENV MYFM__EDI__BUCKET__ID                  newagent-8ec77.appspot.com
ENV MYFM__EDI__BUCKET__CREDENTIALS         /var/www/api/web/private_key.local.json
ENV MYFM__UPLOADS__BUCKET__ID              newagent-8ec77.appspot.com
ENV MYFM__UPLOADS__BUCKET__CREDENTIALS     /var/www/api/web/private_key.local.json
ENV MYFM__URL__INTERNAL__HOSTNAME          localhost
ENV MYFM__URL__EXTERNAL__URL               http://localhost:89/
ENV MYFM__REDIS__URL                       redis://redis
ENV MYFM__MONITORING__CREDENTIALS          /var/www/api/web/private_key.monitoring.json
ENV MYFM__URL__INTERNAL__URL               http://localhost
ENV MYFM__POD__IP                          localhost
ENV MYFM__POD__NAME                        myscm-dev-backend-deployment-
ENV MYFM__HOST__IP                         localhost
ENV MYFM__MONITORING__ENVIRONNEMENT        build
ENV MYFM__APP__SECRET                      ThisTokenIsNotSoSecretChangeIt
ENV PURGE_DEADLINE                          200
ENV PURGE_HARDRUN                           false
ENV PURGE_STEPS                             3
ENV PURGE_MAXORDERS                         1
ENV MYFM__PORTAL__USER                      myscm.public@gmail.com
ENV MYFM__DATALAKE__BUCKET__ID                  newagent-8ec77.appspot.com
ENV MYFM__DATALAKE__BUCKET__CREDENTIALS         /var/www/api/web/private_key.local.json

ENV MYFM__PURGE_ORDER__BUCKET__CREDENTIALS /secrets/edi/credentials.json
ENV MYFM__PURGE_ORDER__BUCKET__ID          fml-build-dig-myscm-dev-edi-bucket