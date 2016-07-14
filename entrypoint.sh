#!/bin/bash
set -e

# check if gams has been installed already
if [ ! -f "/home/gamsuser/.gams_is_installed" ]; then
	wine windows_x86_32.exe /SP- /SILENT
	touch /home/gamsuser/.gams_is_installed
fi 

echo "$@"
#exec "/usr/bin/wine /home/gamsuser/.wine/drive_c/GAMS/win32/24.2/gamside.exe"
exec "$@"

