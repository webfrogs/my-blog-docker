#!/bin/sh

docker pull nswebfrog/blog-ci

docker run --restart=always -d --name blogCI \
    -p 127.0.0.1:8889:80 \
    -v ~/.ssh:/root/.ssh:ro \
    -v /var/www/blogs:/opt/blog/sites \
    nswebfrog/blog-ci 