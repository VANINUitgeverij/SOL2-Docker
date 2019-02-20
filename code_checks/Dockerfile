FROM alpine:3.8
ADD https://php.codecasts.rocks/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub
RUN echo "@php https://php.codecasts.rocks/v3.8/php-7.2" >> /etc/apk/repositories \
    && apk update \
    && apk add --no-cache \
        bash \
        curl \
        git \
        openssh \
        yarn \
        php@php \
        # Packages needed to run composer.
        php-json@php \
        php-phar@php \
        php-mbstring@php \
        php-zlib@php \
        php-openssl@php \
        php-session@php \
        php-bcmath@php \
        php-apcu@php \
        # Needed for the compression option in config/database.php
        php-pdo_mysql@php \
        # Package needed for colors in the terminal.
        php-posix@php \
        # Packages needed to keep Phpstan happy.
        php-pdo@php \
        php-dom@php \
        php-zip@php \
    # Install mcrypt.
    && apk add --virtual build-dependencies --no-cache \
        autoconf  \
        build-base \
        libmcrypt-dev \
    && apk add --no-cache \
        php-dev@php \
        php-pear@php \
        libmcrypt \
    && pecl install mcrypt-1.0.1 \
   # Symlink php7 command -> php
   && ln -s /usr/bin/php7 /usr/bin/php \
   # Install composer
   && curl -sS https://getcomposer.org/installer | php \
   && mv composer.phar /usr/local/bin/composer \
   # Clean mcrypt dependencies.
   && apk del build-dependencies php-dev php-pear \
   && rm -rf /var/cache/apk/*
ENV PATH ${PATH}:vendor/bin:node_modules/.bin
