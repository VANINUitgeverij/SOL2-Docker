FROM ubuntu:18.10
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        gnupg \
        curl \
        ca-certificates \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        git \
        python \
        python-setuptools \
        python-pip \
        yarn \
        libmcrypt-dev \
        make \
        nodejs \
        ssh \
        php-pear \
        php7.2 \
        php7.2-dom \
        php7.2-mbstring \
        php7.2-simplexml \
        php7.2-xml \
        php7.2-zip \
        php7.2-pdo \
        php7.2-tokenizer \
        php7.2-sqlite3 \
        php7.2-mysql \
        php7.2-curl \
        php7.2-imagick \
        php7.2-gd \
        php7.2-xdebug \
        php7.2-apcu \
        php7.2-dev \
    && pip install awscli \
    && pecl install mcrypt-1.0.1 \
    && apt-get remove -y php7.2-dev php-pear make python-pip gnupg python-setuptools \
    && apt-get autoremove -y \
    && apt-get clean -y
ENV PATH ${PATH}:vendor/bin:node_modules/.bin
