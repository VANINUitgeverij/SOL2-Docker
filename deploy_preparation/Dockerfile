FROM node:11.1-alpine
ADD https://php.codecasts.rocks/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub
RUN echo "@php https://php.codecasts.rocks/v3.8/php-7.2" >> /etc/apk/repositories \
    && apk update \
    && apk add --no-cache \
        bash \
        curl \
        git \
        openssh \
        yarn \
        python \
        # Needed for pngquant (try to remove these again, they should not be needed).
        build-base \
        libpng-dev\
        # PHP dependencies.
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
        # Package needed to run artisan commands (sol:composer-scripts).
        php-pdo@php \
        # Package needed for colors in the terminal.
        php-posix@php \
   && apk add --virtual build-dependencies --no-cache \
        py-pip \
   && pip install --no-cache-dir awscli \
   # Clean dependencies for AWS CLI.
   && apk del build-dependencies \
   # Symlink php7 command -> php.
   && ln -s /usr/bin/php7 /usr/bin/php \
   # Install composer.
   && curl -sS https://getcomposer.org/installer | php \
   && mv composer.phar /usr/local/bin/composer \
   # Dependencies needed to install laravel-mix
   && apk add --virtual build-dependencies --no-cache \
     libtool \
     automake \
     nasm  \
     autoconf  \
     python \
   # Install modclean to reduce the size of the node_modules folder.
   && mkdir modclean && cd modclean && yarn add modclean \
   # Pre install laravel mix
   && mkdir -p /home/circleci/SOL2 && cd /home/circleci/SOL2 \
   && yarn add strip-json-comments deep-extend laravel-mix --ignore-optional \
   && rm package.json && rm yarn.lock \
   && cd - \
   # Clean the laravel mix node_modules folder
   && node_modules/.bin/modclean -n default:safe,default:caution -r -p /home/circleci/SOL2 \
   # Remove modclean
   && cd .. && rm -rf modclean \
   # Clean dependencies for laravel mix.
   && apk del build-dependencies \
   && yarn cache clean \
   && rm -rf /var/cache/apk/*
ENV PATH ${PATH}:vendor/bin:node_modules/.bin
