#!/bin/sh

## debug path
echo PWD=`pwd`

# replace "confdir:" in usr/share/alsa/cards/*
## confdir is hardcoded in libasound, there are only two ways to change this:
##  1. change to /snap/pulseaudio/current/usr/share/alsa/
##  2. modify libasound source and build it
## Use the easy way (1) to achive this
## TODO: use fixed version 'current' is not a good idea
find alsa/cards/ -type f | xargs perl -i -pe 's/<confdir:/<\/snap\/pulseaudio\/current\/usr\/share\/alsa\//g'

# add path of snap to config
## insert $SNAP path (/snap/pulseaudio/VER/) before alsa datadir path (/usr/share/alsa)
sed -i 's/{ @func datadir }/{\n\t\t\t\t\t\t@func getenv\n\t\t\t\t\t\tvars [ SNAP ]\n\t\t\t\t\t\tdefault 0\n\t\t\t\t\t}\n\t\t\t\t\t{ @func datadir }/g' alsa/alsa.conf

