FROM ruby:2.4.1-alpine3.6 

RUN apk update --no-cache \
    && apk add --no-cache --virtual .build-deps \
        build-base \
    && apk add --no-cache git openssh \
    # && gem update --system \
    # && gem update \
    && gem install \
        jekyll \
        jekyll-paginate \
        sinatra \
        thin \
    && gem clean \
    && jekyll -v \
    && apk del -f .build-deps


WORKDIR /opt/blog/
COPY hook.rb /opt/blog/

VOLUME /root/.ssh
VOLUME /opt/blog/sites

CMD ["ruby", "hook.rb"]
