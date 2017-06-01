FROM debian:jessie-slim

ENV DEBIAN_FRONTEND noninteractive

## Base requirements and upgrades
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils \
    sudo \
    lsb-release \
    curl \
    git \
    make \
    g++ \
    libyaml-dev \
    ssh

RUN apt-get dist-upgrade -y

## Install PHP
RUN apt-get update && apt-get install -y --no-install-recommends apt-transport-https ca-certificates
RUN curl -SLO https://packages.sury.org/php/apt.gpg && mv apt.gpg /etc/apt/trusted.gpg.d/php.gpg
RUN echo "deb https://packages.sury.org/php/ jessie main" > /etc/apt/sources.list.d/php.list
RUN apt-get update && apt-get install -y --no-install-recommends \
    php7.1 \
    php7.1-dom \
    php7.1-mbstring \
    php7.1-simplexml \
    php7.1-xml \
    php7.1-zip \
    php7.1-pdo \
    php7.1-tokenizer \
    php7.1-mysql \
    php7.1-curl \
    php7.1-mcrypt \ 
    php7.1-imagick \
    php7.1-gd \
    php7.1-xdebug

# Disable xdebug extension by default
RUN rm /etc/php/7.1/cli/conf.d/20-xdebug.ini

## Install Python
RUN apt-get update && apt-get install -y --no-install-recommends python python-dev python-pip

## Install AWS CLI
RUN pip install --upgrade awscli

## Install Composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

## Install Node.js
RUN curl -SLO https://deb.nodesource.com/setup_7.x
RUN bash setup_7.x && rm setup_7.x
RUN apt-get update && apt-get install -y --no-install-recommends nodejs

## Install Yarn
RUN curl -SLO https://dl.yarnpkg.com/debian/pubkey.gpg
RUN apt-key add pubkey.gpg
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y --no-install-recommends yarn

## Install Dredd
RUN npm install -g --progress=false -q --unsafe-perm dredd hercule

## Install Apiary
RUN apt-get update && apt-get install -y --no-install-recommends ruby-dev ruby
RUN gem install apiaryio

## Create user 'default'
RUN useradd -ms /bin/bash default
RUN usermod -aG sudo default
RUN echo "default:default" | chpasswd
USER default
WORKDIR /home/default

ENV PATH ${PATH}:vendor/bin:node_modules/.bin

ENV DEBIAN_FRONTEND teletype
