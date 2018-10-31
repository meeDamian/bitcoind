#!/bin/bash
set -e

docker run --rm --name=bitcoindtest ruimarinho/bitcoin-core:0.17-alpine uname -a

if [ "$ARCH" == "amd64" ]; then
  docker run --rm --name=bitcoindtest ruimarinho/bitcoin-core:0.17-alpine bitcoin-cli --version
fi
