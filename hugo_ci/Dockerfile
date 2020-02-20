FROM golang:1.13.8-alpine3.11 as builder
RUN apk update --no-cache \
	&& apk add --no-cache git


FROM builder as hugo

WORKDIR /opt/
RUN git clone https://github.com/gohugoio/hugo.git \
	&& cd hugo \
	&& CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /opt/build/hugo .

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
COPY --from=hugo /opt/build/hugo /opt/bin/hugo
COPY --from=hook /opt/build/hook /opt/bin/hook

HEALTHCHECK --interval=10s --timeout=3s --retries=3 \
  CMD curl -fs http://localhost/health || exit 1

CMD ["/opt/bin/hook"]


