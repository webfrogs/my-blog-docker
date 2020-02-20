#!/bin/sh
set -e

docker rm -f hugo_ci || true > /dev/null 2>&1
docker run --restart=always -d --name hugo_ci \
    -p 127.0.0.1:8890:80 \
    -v $HOME/.ssh/hugo_ci:/root/.ssh/id_rsa:ro \
    -v /var/www/nswebfrog.com:/opt/blog/sites \
    nswebfrog/hugo_ci
