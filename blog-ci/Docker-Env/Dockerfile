FROM ruby:2.4.1-alpine3.6 

RUN apk update --no-cache \
    && apk add --no-cache --virtual .build-deps \
        build-base \
    && apk add --no-cache git openssh \
    && gem install \
        jekyll \
        jekyll-paginate \
    && gem clean \
    && jekyll -v \
    && apk del -f .build-deps
