#!/bin/bash
set -e

docker run --rm bitcoind uname -a

if [ "$ARCH" == "amd64" ]; then
  docker run --rm bitcoind bitcoin-cli --version
fi
