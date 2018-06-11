FROM alpine:3.7
ADD https://php.codecasts.rocks/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub
RUN echo "@php https://php.codecasts.rocks/v3.7/php-7.1" >> /etc/apk/repositories \
    && apk add --update --no-cache \
        bash \
        curl \
        git \
        openssh \
        yarn \
        php@php \
        php-mcrypt@php \
        php-json@php \
        php-phar@php \
        php-pdo@php \
        php-mbstring@php \
        php-openssl@php \
        php-zlib@php \
        php-dom@php \
        php-zip@php \
        php-posix@php \
   # Symlink php7 command -> php
   && ln -s /usr/bin/php7 /usr/bin/php \
   # Install composer
   && curl -sS https://getcomposer.org/installer | php \
   && mv composer.phar /usr/local/bin/composer \
   && rm -rf /var/cache/apk/*
ENV PATH ${PATH}:vendor/bin:node_modules/.bin
