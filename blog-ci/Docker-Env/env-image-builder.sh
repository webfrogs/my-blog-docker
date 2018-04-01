#!/bin/sh
set -e

cd $(dirname $0)

if [ -d "build" ]; then
    rm -rf build
fi

docker build -t nswebfrog/blog-ci-env .