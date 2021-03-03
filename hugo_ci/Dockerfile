FROM golang:1.13.8-alpine3.11 as builder
RUN apk update --no-cache \
	&& apk add --no-cache git

FROM builder as hook
WORKDIR /opt/
COPY hook.go /opt/hook/hook.go
RUN cd hook \
	&& CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /opt/build/hook .

FROM alpine:3.11.3
RUN apk update --no-cache \
	&& apk add --no-cache git curl openssh \
	&& mkdir -p /root/.ssh \
	&& echo "Host *" > /root/.ssh/config \
	&& echo "  StrictHostKeyChecking no" >> /root/.ssh/config
COPY hugo_bin/hugo /opt/bin/hugo
COPY --from=hook /opt/build/hook /opt/bin/hook

HEALTHCHECK --interval=10s --timeout=3s --retries=3 \
  CMD curl -fs http://localhost/health || exit 1

COPY docker_entrypoint.sh /opt/docker_entrypoint.sh

ENTRYPOINT ["/opt/docker_entrypoint.sh"]

