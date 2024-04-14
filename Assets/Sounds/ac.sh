#!/bin/bash

INPUT=${1:-"20"}
T="-"$INPUT"dB"


FILES=($(ls | grep '.m4a' | sed -e 's|.m4a||'))

for f in ${FILES[@]}; do
	echo "Converting $f.m4a to .ogg and .wav"
	if ffmpeg -y -i $f.m4a -af "silenceremove=1:0:$T,silenceremove=stop_periods=-1:stop_duration=0.1:stop_threshold=$T" converted/trimmed/$f.wav converted/trimmed/$f.ogg 1>/dev/null 2>/dev/null; then
		echo "$f.m4a trimmed with noice thershold of $T"
		if ffmpeg -y -i $f.m4a converted/wav/$f.wav 1>/dev/null 2>/dev/null; then
			echo "$f.m4a converted"
			mv $f.m4a converted
		fi
	else 
		echo "$f.m4a failed"
	fi
done
