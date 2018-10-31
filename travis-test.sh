#!/bin/bash
set -e

if [ "$ARCH" == "amd64" ]; then
  # test image
  docker run --rm --name=bitcoindtest ruimarinho/bitcoin-core:0.17-alpine bitcoin-cli --version
fi
