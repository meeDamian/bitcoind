#!/bin/bash
set -e

docker run --rm --name=bitcoindtest bitcoind uname -a

if [ "$ARCH" == "amd64" ]; then
  docker run --rm --name=bitcoindtest bitcoind bitcoin-cli --version
fi
