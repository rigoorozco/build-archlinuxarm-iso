#!/bin/bash

# This script is meant to be run on the host machine

PROJECT_ROOT=$(git rev-parse --show-toplevel)

mkdir -p ${PROJECT_ROOT}/work
mkdir -p ${PROJECT_ROOT}/output

echo "Building Docker image.." && \
docker build -t flaccid/arch-makepkg:latest . && \
echo "Running Docker build.." &&                 \
docker run -ti --rm --privileged                 \
	--name aarch64-iso-builder                   \
	-v ${PROJECT_ROOT}/scripts:/scripts          \
	-v ${PROJECT_ROOT}/work:/work                \
	-v ${PROJECT_ROOT}/output:/output            \
	-v ${PROJECT_ROOT}/archiso:/archiso          \
	flaccid/arch-makepkg:latest                  \
	/scripts/build-iso.sh &&                     \
echo "Build competed successfully!"
