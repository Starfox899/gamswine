# gamside
Docker container with GAMS and GAMSIDE via wine

## Define name and version

```
IMAGE_NAME=gamswine
VERSION=24.5.6
FULL_NAME=starfox/${IMAGE_NAME}:${VERSION}
```

## Build GAMSIDE-Image

```
docker build --no-cache -t ${FULL_NAME} .
```

## Create GAMSIDE-Container for first time

```
docker rm "${IMAGE_NAME}_${VERSION}"
docker run -it --name "${IMAGE_NAME}_${VERSION}" -e DISPLAY=${DISPLAY} -v /tmp/.X11-unix:/tmp/.X11-unix:ro ${FULL_NAME} 
```

## Restart existing container

```
docker start -i ${IMAGE_NAME}_${VERSION}
```
