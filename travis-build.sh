#!/bin/bash
set -e

docker version
uname -a

echo "Updating Docker engine to have multi-stage builds and manifest command"
sudo service docker stop
curl -fsSL get.docker.com | sh

echo "Enabling docker client experimental features"
mkdir -p ~/.docker
echo '{ "experimental": "enabled" }' > ~/.docker/config.json

docker version

if [ -d tmp ]; then
  docker rm build
  rm -rf tmp
fi

if [ "$ARCH" == "arm32v6" ]; then
#    sudo apt-get install -y qemu qemu-user-static binfmt-support
    wget -N https://github.com/multiarch/qemu-user-static/releases/download/v3.0.0/qemu-arm-static

    docker run --rm --privileged multiarch/qemu-user-static:register

    cp /usr/bin/qemu-arm-static .

    echo "ensuring arm32v6 images are used"

    sed -ie 's/FROM alpine/FROM arm32v6\/alpine/g' Dockerfile
fi

docker build --no-cache -t bitcoind .
