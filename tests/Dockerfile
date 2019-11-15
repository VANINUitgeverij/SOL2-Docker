FROM alpine:3.8
ADD https://dl.bintray.com/php-alpine/key/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub
RUN echo "@php https://dl.bintray.com/php-alpine/v3.8/php-7.2" >> /etc/apk/repositories \
    && apk update \
    && apk add --no-cache \
        bash \
        curl \
        git \
        openssh \
        yarn \
    && apk add --no-cache \
        php@php \
        # Packages needed to run composer.
        php-json@php \
        php-phar@php \
        php-mbstring@php \
        php-zlib@php \
        php-openssl@php \
        # Package needed for colors in the terminal.
        php-posix@php \
        # Packages for SOL2.
        php-session@php \
        php-dom@php \
        php-pdo@php \
        php-zip@php \
        php-iconv@php \
        php-imagick@php \
        php-gd@php \
        php-bcmath@php \
        # Packages for testing.
        php-apcu@php \
        php-pdo_sqlite@php \
        php-pdo_mysql@php \
        php-redis@php \
        # Needed for Phanybar dependency of the results printer.
        php-sockets@php \
        # Needed for iOmniwize import.
        php-xmlreader@php \
   # Workaround for iconv issue in alpine (https://github.com/docker-library/php/issues/240)
   && apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community gnu-libiconv \
   # Symlink php7 command -> php
   && ln -s /usr/bin/php7 /usr/bin/php \
   # Install composer
   && curl -sS https://getcomposer.org/installer | php \
   && mv composer.phar /usr/local/bin/composer \
   # Dependencies needed to install laravel-mix and dredd.
   && apk add --virtual build-dependencies --no-cache \
        libtool \
        automake \
		nasm  \
		autoconf  \
		build-base \
		libpng-dev\
		python \
        libmcrypt-dev \
   # Install mcrypt.
   && apk add --no-cache \
       php-dev@php \
       php-pear@php \
       libmcrypt \
    && pecl install mcrypt-1.0.1 \
    # Install modclean to reduce the size of the node_modules folder.
    && mkdir modclean && cd modclean && yarn add modclean \
    # Install hercule and dredd
    && yarn global add hercule dredd --ignore-optional --prefix=/usr/local \
    # Clean the global node_modules folder
    && node_modules/.bin/modclean -n default:safe,default:caution -r -p $(yarn global dir) \
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
    # Clean mcrypt dependencies.
    && apk del php-dev php-pear \
    && yarn cache clean \
    && rm -rf /var/cache/apk/*
ENV PATH ${PATH}:vendor/bin:node_modules/.bin
# Workaround for iconv issue
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php
