FROM ruby:2.4.1-alpine3.6 

RUN apk update --no-cache \
    && apk add --no-cache --virtual .build-deps \
        build-base \
    && apk add --no-cache git openssh \
    && gem install \
        jekyll \
        jekyll-paginate \
        sinatra \
        thin \
    && apk del -f .build-deps


WORKDIR /opt/blog/
COPY hook.rb /opt/blog/

VOLUME /root/.ssh
VOLUME /opt/blog/sites

CMD ["ruby", "hook.rb"]
