#!/bin/bash
set -e

# check if gams has been installed already
if [ ! -f "/home/gamsuser/.gams_is_installed" ]; then
	wine windows_x86_32.exe /SP- /SILENT
	touch /home/gamsuser/.gams_is_installed
fi 

#echo "$@"

if [ $# -lt 1 ]; then
	GAMSIDE=`find / -iname gamside.exe 2>/dev/null | sort -r | head -n 1`
	echo "GAMSIDE found at ${GAMSIDE}"
	exec /usr/bin/wine ${GAMSIDE}
else
	exec $@
fi

