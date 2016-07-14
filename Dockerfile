FROM ubuntu:14.04 
MAINTAINER sascha.herrmann.consulting@gmail.com

# Inspired by suchja/wine, monokrome/wine and ColinHuang/docker-ubuntu-wine 

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root
USER root

# We will use i386 for wine
RUN dpkg --add-architecture i386

# Install some tools required for creating the image
RUN apt-get update &&\ 
     		apt-get install -yq --no-install-recommends \
		curl \
		unzip \
		ca-certificates


# Install wine and related packages
RUN apt-get install -y --no-install-recommends wine:i386 

# Clean up image
RUN rm -rf /var/lib/apt/lists/*

# Use the latest version of winetricks
RUN curl -SL 'https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks' -o /usr/local/bin/winetricks \
		&& chmod +x /usr/local/bin/winetricks

# Get latest version of mono for wine
ENV WINE_MONO_VERSION 0.0.8
RUN mkdir -p /usr/share/wine/mono \
	&& curl -SL 'http://sourceforge.net/projects/wine/files/Wine%20Mono/$WINE_MONO_VERSION/wine-mono-$WINE_MONO_VERSION.msi/download' -o /usr/share/wine/mono/wine-mono-$WINE_MONO_VERSION.msi \
	&& chmod +x /usr/share/wine/mono/wine-mono-$WINE_MONO_VERSION.msi

# Wine really doesn't like to be run as root, so let's use a non-root user
RUN useradd -m -d /home/gamsuser -U gamsuser
USER gamsuser
ENV HOME /home/gamsuser
ENV WINEPREFIX /home/gamsuser/.wine
ENV WINEARCH win32
WORKDIR /home/gamsuser

#RUN curl -SL 'https://d37drm4t2jghv5.cloudfront.net/distributions/24.7.3/windows/windows_x86_32.exe' -o /home/gamsuser/windows_x86_32.exe 
#RUN curl -SL 'https://d37drm4t2jghv5.cloudfront.net/distributions/24.6.1/windows/windows_x86_32.exe' -o /home/gamsuser/windows_x86_32.exe 
RUN curl -SL 'https://d37drm4t2jghv5.cloudfront.net/distributions/24.5.6/windows/windows_x86_32.exe' -o /home/gamsuser/windows_x86_32.exe 

RUN echo "alias winegui='wine explorer /desktop=DockerDesktop,1024x768'" > ~/.bash_aliases 

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
