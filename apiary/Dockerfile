FROM alpine:3.8
RUN apk add --update --no-cache \
        bash \
        curl \
        git \
        openssh \
        yarn \
        ruby \
    && apk add --virtual build-dependencies --update --no-cache \
        g++ \
        ruby-dev \
        make \
    # Install Apiary.
    && gem install io-console --no-document \
    && gem install apiaryio --no-document \
    # Clean dependencies for Apiary.
    && apk del build-dependencies \
    # Install modclean to reduce the size of the node_modules folder.
    && mkdir modclean && cd modclean && yarn add modclean \
    # Install hercule
    && yarn global add hercule --ignore-optional --prefix=/usr/local \
    # Clean the global node_modules folder
    && node_modules/.bin/modclean -n default:safe,default:caution -r -p $(yarn global dir) \
    # Remove modclean
    && cd .. && rm -rf modclean \
    && yarn cache clean \
    && rm -rf /var/cache/apk/*
ENV PATH ${PATH}:node_modules/.bin
