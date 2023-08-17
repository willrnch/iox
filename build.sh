#!/bin/bash

set -ex

git submodule update --init --recursive

cd influxdb_iox
COMMIT_HASH="$(git describe --always --dirty --abbrev=64)"
cd ..

echo $COMMIT_HASH

IMAGE_TAG="ghcr.io/willrnch/iox:$COMMIT_HASH"

ARCH="$(docker info -f json | jq -r .Architecture)"

AVX2=false

if [ $ARCH == "aarch64" ]; then
    PLATFORM="linux/arm64"
elif [ $ARCH == "x86_64" ]
then
    PLATFORM="linux/amd64"

    if [ $(gcc -march=native -Q --help=target | grep -- "-mavx2 " | grep enabled | wc -l) == "1" ]; then
        AVX2=true
    fi
else
    echo "Unsupported architecture $ARCH"
    exit 1
fi

if [ "$AVX2" = true ]; then
    IMAGE_TAG="$IMAGE_TAG-avx2"
fi

docker build . \
    -t $IMAGE_TAG \
    --build-arg="COMMIT_HASH=$COMMIT_HASH" \
    --platform="$PLATFORM"
