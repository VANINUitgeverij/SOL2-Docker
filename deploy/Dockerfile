FROM alpine:3.7
RUN apk update \
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
