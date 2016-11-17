#!/bin/bash

for LINE in `tail -n +2 version-links.csv`;
do
	VERSION=`echo ${LINE} | gawk -F, '{ print $1 }'`
	./build.sh --version ${VERSION}
done
