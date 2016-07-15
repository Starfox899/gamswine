#!/bin/bash
IMAGE_NAME=gamswine
VERSION=24.7.3
FULL_NAME=starfox/${IMAGE_NAME}:${VERSION}

# Build base image
docker build --no-cache -t ${FULL_NAME} .

# Run base image for the first time, this will install GAMS automatically
docker rm "${IMAGE_NAME}_${VERSION}"
docker run -it --name "${IMAGE_NAME}_${VERSION}" -e DISPLAY=${DISPLAY} -v /tmp/.X11-unix:/tmp/.X11-unix:ro ${FULL_NAME} 

# Restart container
docker start -i ${IMAGE_NAME}_${VERSION}

