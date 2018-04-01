#!/bin/sh
set -e

cd $(dirname $0)

if [ -d "build" ]; then
    rm -rf build
fi

CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o build/hook hook.go

docker build -t nswebfrog/blog-ci .