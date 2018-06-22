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
   && rm -rf /var/cache/apk/*
ENV PATH ${PATH}:vendor/bin:node_modules/.bin
