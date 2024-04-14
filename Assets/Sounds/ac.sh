#!/bin/bash

FOLDER=${1:""}

FILES=($(ls $1 | grep '.m4a' | sed -e 's|.m4a||'))

for f in ${FILES[@]}; do
	echo "Converting $f.m4a to .ogg and .wav"
	if ffmpeg -i $f.m4a $f.ogg $f.wav 1>/dev/null 2>&1; then
		echo "$f.m4a converted"
	else 
		echo "$f.m4a failed"
	fi
done