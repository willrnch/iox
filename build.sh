#!/bin/bash

set -ex

git submodule update --init --recursive

cd influxdb_iox
COMMIT_HASH="$(git describe --always --dirty --abbrev=64)"
cd ..

IMAGE_TAG="ghcr.io/willrnch/iox:$COMMIT_HASH"

ARCH="$(docker info -f json | jq -r .Architecture)"

if [ $ARCH == "aarch64" ]; then
    PLATFORM="linux/arm64"
elif [ $ARCH == "x86_64" ]; then
    PLATFORM="linux/amd64"

    CPU_FAMILY=$(cat /sys/devices/cpu/caps/pmu_name)

    sed -i "s/haswell/$CPU_FAMILY/g" ./influxdb_iox/.cargo/config

    IMAGE_TAG="$IMAGE_TAG-$CPU_FAMILY"
else
    echo "Unsupported architecture $ARCH"
    exit 1
fi

docker build . \
    -t $IMAGE_TAG \
    --build-arg="COMMIT_HASH=$COMMIT_HASH" \
    --platform="$PLATFORM"
