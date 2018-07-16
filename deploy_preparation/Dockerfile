FROM alpine:3.7
ADD https://php.codecasts.rocks/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub
RUN echo "@php https://php.codecasts.rocks/v3.7/php-7.1" >> /etc/apk/repositories \
    && apk add --update --no-cache \
        bash \
        curl \
        git \
        openssh \
        yarn \
        python \
        php@php \
        # Packages needed to run composer.
        php-json@php \
        php-phar@php \
        php-mbstring@php \
        php-zlib@php \
        php-openssl@php \
        # Package needed to run artisan commands (sol:composer-scripts).
        php-pdo@php \
        # Package needed for colors in the terminal.
        php-posix@php \
   && apk add --virtual build-dependencies --update --no-cache \
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
