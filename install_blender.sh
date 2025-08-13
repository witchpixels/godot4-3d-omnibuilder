#!/bin/bash
DESIRED_BLENDER_VERSION=$1

if [[ -z "$DESIRED_BLENDER_VERSION" ]]; then
    echo "no blender version supplied, installing $BLENDER_VERSION"
    DESIRED_BLENDER_VERSION=$BLENDER_VERSION
else
    echo "installing blender $DESIRED_BLENDER_VERSION over $BLENDER_VERSION"
fi

BLENDER_URL_ROOT=${DESIRED_BLENDER_VERSION%.*}

wget -nv https://download.blender.org/release/Blender"${BLENDER_URL_ROOT}"/blender-"${DESIRED_BLENDER_VERSION}"-linux-x64.tar.xz
tar -xJf ./blender-"${DESIRED_BLENDER_VERSION}"-linux-x64.tar.xz

mv ./blender-"${DESIRED_BLENDER_VERSION}"-linux-x64 /opt/blender