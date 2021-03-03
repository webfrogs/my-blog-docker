HUGO_VERSION := 0.81.0

all: push
.PHONY: all push build

build:
	rm -rf hugo_bin
	mkdir -p hugo_bin
	curl -L -o hugo_bin/hugo.tar.gz https://github.com/gohugoio/hugo/releases/download/v$(HUGO_VERSION)/hugo_$(HUGO_VERSION)_Linux-64bit.tar.gz
	cd hugo_bin && tar xvzf hugo.tar.gz
	docker build -t nswebfrog/hugo_ci .

push: build
	docker push nswebfrog/hugo_ci

