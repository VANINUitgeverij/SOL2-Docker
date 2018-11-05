FROM alpine:3.7
ADD https://php.codecasts.rocks/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub
RUN echo "@php https://php.codecasts.rocks/v3.7/php-7.1" >> /etc/apk/repositories \
    && apk update \
    && apk add --no-cache \
        bash \
        curl \
        openssh \
        python \
   && apk add --virtual build-dependencies --no-cache \
        py-pip \
   && pip install --no-cache-dir awscli \
   # Clean dependencies for AWS CLI.
   && apk del build-dependencies \
   && rm -rf /var/cache/apk/*
