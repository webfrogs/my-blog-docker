#!/bin/sh
set -e

hasExitedDockerContainer() {
    containerName="$1"
    exitedContainer=$(docker ps --format '{{.Names}}' -f status=exited -f name=${containerName} | grep "^${containerName}\$") || true
    if [ "${exitedContainer}" ]; then
        return 0
    else
        return 1
    fi
}

hasRunningDockerContainer() {
    containerName="$1"
    runningContainer=$(docker ps --format '{{.Names}}' -f name=${containerName} | grep "^${containerName}\$") || true
    if [ "${runningContainer}" ]; then
        return 0
    else
        return 1
    fi
}

ContainerName="blogCI"

if $(hasRunningDockerContainer "${ContainerName}"); then 
    docker stop ${ContainerName} && docker rm ${ContainerName}
fi

if $(hasExitedDockerContainer "${ContainerName}"); then 
    docker rm ${ContainerName} 
fi

docker run --restart=always -d --name ${ContainerName} \
    -p 127.0.0.1:8889:80 \
    -v $HOME/.ssh:/root/.ssh:ro \
    -v /var/www/blogs:/opt/blog/sites \
    nswebfrog/blog-ci 