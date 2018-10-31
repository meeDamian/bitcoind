#!/bin/bash
set -e

image="meedamian/bitcoind"
docker tag bitcoind "$image:linux-$ARCH-$TRAVIS_TAG"
docker push "$image:linux-$ARCH-$TRAVIS_TAG"

if [ "$ARCH" == "amd64" ]; then
  set +e
  echo "Waiting for other images $image:linux-arm32v6-$TRAVIS_TAG"
  until docker run --rm stefanscherer/winspector "$image:linux-arm32v6-$TRAVIS_TAG"
  do
    sleep 15
    echo "Try again"
  done
  set -e

  echo "Pushing manifest $image:$TRAVIS_TAG"
  docker -D manifest create "$image:$TRAVIS_TAG" \
    "$image:linux-amd64-$TRAVIS_TAG" \
    "$image:linux-arm32v6-$TRAVIS_TAG"
  docker manifest annotate "$image:$TRAVIS_TAG" "$image:linux-arm32v6-$TRAVIS_TAG" --os linux --arch arm --variant v6
  docker manifest push "$image:$TRAVIS_TAG"

  echo "Pushing manifest $image:latest"
  docker -D manifest create "$image:latest" \
    "$image:linux-amd64-$TRAVIS_TAG" \
    "$image:linux-arm32v6-$TRAVIS_TAG"
  docker manifest annotate "$image:latest" "$image:linux-arm32v6-$TRAVIS_TAG" --os linux --arch arm --variant v6
  docker manifest push "$image:latest"
fi
