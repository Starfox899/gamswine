# GAMSWINE

This is a docker conatiner to run GAMS and GAMSIDE via wine for linux users.

# Initial setup (one-time action)

```
# Define version you want and nee
IMAGE_NAME=gamswine
VERSION=24.7.3
FULL_NAME=docker.io/starfox/${IMAGE_NAME}:${VERSION}

# Pull image from dockerhub
docker pull ${FULL_NAME}

# In case you have already a named container, you might want to remove this.
# Beware, all data inside this container will be lost!
# docker rm "${IMAGE_NAME}_${VERSION}"

# Create GAMSIDE-Container for first time
docker run -it --name "${IMAGE_NAME}_${VERSION}" -e DISPLAY=${DISPLAY} -v /tmp/.X11-unix:/tmp/.X11-unix:ro ${FULL_NAME} 
```
The container will automatically start the installation of GAMS and its dependencies. Please hit "Install" once asked.

After the initial installation of GAMS, this container can and should be reused. This will save startup and configuration time, as well as will allow to persist data inside the container.

# Restart existing container

Once the initial setup is completed, you can restart your conatiner quickly with this command:
```
docker start -i ${IMAGE_NAME}_${VERSION}
```
