FROM ruby:2.4.1-alpine3.6 

RUN apk update --no-cache \
    && apk add --no-cache --virtual .build-deps \
        build-base \

    && gem install \
        jekyll \
        jekyll-paginate \
    && apk del -f .build-deps

VOLUME /srv/jekyll
WORKDIR /srv/jekyll