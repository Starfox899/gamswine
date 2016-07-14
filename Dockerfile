FROM ubuntu:16.04 
MAINTAINER sascha.herrmann.consulting@gmail.com

# Inspired by suchja/wine, monokrome/wine and ColinHuang/docker-ubuntu-wine 

ENV DEBIAN_FRONTEND noninteractive
ENV WINEPREFIX /home/gamsuser/.wine
ENV WINEARCH win32

RUN useradd -m -d /home/gamsuser -U gamsuser && \
	dpkg --add-architecture i386 && \
        apt-get update -y && \
        apt-get install -y software-properties-common curl && \
	add-apt-repository -y ppa:wine/wine-builds && \
        apt-get update -y && \
        apt-get install -y --install-recommends winehq-staging && \
	apt-get purge -y software-properties-common && \
	apt-get autoclean -y && \
	rm -rf /var/lib/apt/lists/* && \
	echo "alias winegui='wine explorer /desktop=DockerDesktop,1024x768'" > /home/gamsuser/.bash_aliases && \
	curl -SL 'https://d37drm4t2jghv5.cloudfront.net/distributions/24.7.3/windows/windows_x86_32.exe' -o /home/gamsuser/windows_x86_32.exe && \

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

USER gamsuser
WORKDIR /home/gamsuser
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
