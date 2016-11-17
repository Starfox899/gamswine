#!/bin/bash

for LINE in `tail -n +2 version-links.csv`;
do
	VERSION=`echo ${LINE} | gawk -F, '{ print $1 }'`
	DOWNLOAD=`echo ${LINE} | gawk -F, '{ print $2 }'`
	cp Dockerfile.template Dockerfile.${VERSION}
	sed -i 's@PUT_DOWNLOAD_LINK_HERE@'"${DOWNLOAD}"'@' Dockerfile.${VERSION}
done
