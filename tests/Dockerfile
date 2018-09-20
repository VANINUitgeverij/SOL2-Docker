FROM alpine:3.7
ADD https://php.codecasts.rocks/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub
RUN apk add --update --no-cache \
        bash \
        curl \
        git \
        openssh \
        yarn \
    && apk add --update --no-cache --repository https://php.codecasts.rocks/v3.7/php-7.1 \
        php \
        # Packages needed to run composer.
        php-json \
        php-phar \
        php-mbstring \
        php-zlib \
        php-openssl \
        # Package needed for colors in the terminal.
        php-posix \
        # Packages for SOL2.
        php-session \
        php-dom \
        php-pdo \
        php-mcrypt \
        php-zip \
        php-iconv \
        php-imagick \
        php-gd \
        # Packages for testing.
        php-apcu \
        php-pdo_sqlite \
        php-pdo_mysql \
        php-redis \
        # Needed for Phanybar dependency of the results printer.
        php-sockets \
   # Workaround for iconv issue in alpine (https://github.com/docker-library/php/issues/240)
   && apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing gnu-libiconv \
   # Symlink php7 command -> php
   && ln -s /usr/bin/php7 /usr/bin/php \
   # Install composer
   && curl -sS https://getcomposer.org/installer | php \
   && mv composer.phar /usr/local/bin/composer \
   # Dependencies needed to install laravel-mix and dredd.
   && apk add --virtual build-dependencies --update --no-cache \
        libtool \
        automake \
		nasm  \
		autoconf  \
		build-base \
		libpng-dev\
		python \
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
    && yarn cache clean \
    && rm -rf /var/cache/apk/*
ENV PATH ${PATH}:vendor/bin:node_modules/.bin
# Workaround for iconv issue
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php
