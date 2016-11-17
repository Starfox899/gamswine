#!/bin/bash -x

set -e

IMAGE_NAME=gamswine
VERSION=latest
FULL_NAME=starfox/${IMAGE_NAME}:${VERSION}

# Build base image
if [ $# -gt 0 ]; then 
	if [ "$1" == "--no-cache" ]; then
		docker build --no-cache -t ${FULL_NAME} .
	elif [ "$1" == "--version" ]; then
		VERSION=$2
		FULL_NAME=starfox/${IMAGE_NAME}:${VERSION}
		echo ${VERSION}
		docker build -t ${FULL_NAME} -f Dockerfile.${VERSION} .
	fi
else
	docker build -t ${FULL_NAME} .
fi

# Run base image for the first time, this will install GAMS automatically
docker rm "${IMAGE_NAME}_${VERSION}"
docker run -it --ipc=host --name "${IMAGE_NAME}_${VERSION}" -e DISPLAY=${DISPLAY} -v /tmp/.X11-unix:/tmp/.X11-unix:ro ${FULL_NAME} 

# Restart container
docker start -i ${IMAGE_NAME}_${VERSION}

