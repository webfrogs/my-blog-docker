#!/bin/sh
set -e

cd $(dirname $0)

docker build -t nswebfrog/hugo_ci .
docker push nswebfrog/hugo_ci


