all: push
.PHONY: all push build

build:
	rm -rf build
	CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o build/hook hook.go
	docker build -t nswebfrog/blog_ci .
push: build
	docker push nswebfrog/blog_ci

