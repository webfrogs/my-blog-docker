FROM ruby:2.5.3-alpine3.8 

EXPOSE 80
VOLUME /root/.ssh
VOLUME /opt/blog/sites

RUN apk update --no-cache \
    && apk add --no-cache --virtual .build-deps \
        build-base \
    && apk add --no-cache git openssh curl \
    && gem install \
        jekyll \
        jekyll-paginate \
    && gem clean \
    && jekyll -v \
    && apk del -f .build-deps

WORKDIR /opt/blog/
COPY ./build/hook /opt/blog/hook

HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD curl -fs http://localhost/health || exit 1

COPY docker_entrypoint.sh /opt/docker_entrypoint.sh
ENTRYPOINT ["/opt/docker_entrypoint.sh"]
