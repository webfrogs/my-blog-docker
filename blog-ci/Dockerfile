FROM ruby:2.4.1-alpine3.6 

EXPOSE 80
VOLUME /root/.ssh
VOLUME /opt/blog/sites

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

WORKDIR /opt/blog/
COPY ./build/hook /opt/blog/hook

CMD ["/opt/blog/hook"]
