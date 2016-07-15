FROM ubuntu:16.04 
MAINTAINER sascha.herrmann.consulting@gmail.com

# Inspired by suchja/wine, monokrome/wine and ColinHuang/docker-ubuntu-wine 

ENV DEBIAN_FRONTEND noninteractive
ENV WINEPREFIX /home/gamsuser/.wine
ENV WINEARCH win32

RUN useradd -m -d /home/gamsuser -U gamsuser && \
	dpkg --add-architecture i386 && \
        apt-get update -y && \
        apt-get install -y software-properties-common curl xvfb && \
	add-apt-repository -y ppa:wine/wine-builds && \
        apt-get update -y && \
        apt-get install -y --install-recommends winehq-staging && \
	apt-get purge -y software-properties-common && \
        apt-get autoclean -y && \
        apt-get autoremove -y && \
        rm -rf /var/lib/apt/lists/* 

# Remember, since we use winehq-staging, we are supposed to use the latest uneven version of mono, here 4.6.3
RUN     mkdir -p /opt/wine-staging/share/wine/mono && \
	curl -SL 'http://dl.winehq.org/wine/wine-mono/4.6.3/wine-mono-4.6.3.msi' -o '/opt/wine-staging/share/wine/mono/wine-mono-4.6.3.msi' 

# Remember, since we use winehq-staging, we are supposed to use the latest uneven version of gecko, here 2.47
RUN     mkdir -p /opt/wine-staging/share/wine/gecko && \ 
 	curl -SL 'http://dl.winehq.org/wine/wine-gecko/2.47/wine_gecko-2.47-x86.msi' -o '/opt/wine-staging/share/wine/gecko/wine_gecko-2.47-x86.msi' 

# Download appropriate GAMS-Version
RUN     curl -SL 'https://d37drm4t2jghv5.cloudfront.net/distributions/24.7.3/windows/windows_x86_32.exe' -o /home/gamsuser/windows_x86_32.exe


COPY entrypoint.sh /usr/local/bin/entrypoint.sh
USER gamsuser
WORKDIR /home/gamsuser
# Deactivated GAMS-Installation during image creation for the moment
RUN xvfb-run -a wine windows_x86_32.exe /SP- /SILENT && touch /home/gamsuser/.gams_is_installed

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
