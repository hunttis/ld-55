#!/bin/bash

function help() {
	echo "Usage: $0 [-i <input>] [-t <filetype>] [-d <decibel>]"
	echo "  -i, --input    Input file. If left out, all files of spesified type in the current directory will be converted."
	echo "  -t, --type     File type to convert from (default: m4a)"
	echo "  -d, --decibel  Decibel level to trim (default: 20)"
	exit 0
}

while [[ "$#" -gt 0 ]]; do
	case $1 in
	-i | --input)
		INPUT="$2"
		shift
		;;
	-t | --type)
		TYPE="$2"
		shift
		;;
	-d | --decibel)
		DECIBEL="$2"
		shift
		;;
	-h | --help)
		help
		;;
	*)
		echo "Unknown parameter passed: $1"
		exit 1
		;;
	esac
	shift
done

mkdir -p converted/trimmed/{ogg,wav}
mkdir -p converted/original/{ogg,wav}

if [ -z "$TYPE" ]; then
	TYPE="m4a"
fi

if [ -z "$DECIBEL" ]; then
	DECIBEL="20"
fi

T="-"$DECIBEL"dB"

if [ -z "$INPUT" ]; then
	FILES=($(ls | grep ".$TYPE" | sed -e "s|.$TYPE||"))
else
	FILES=($INPUT)
fi

if [ -z "$INPUT" ]; then
	read -p "No input file provided. Convert all files of type .$TYPE in current directory? (Y/n) " -n 1 -r
	echo
	if [[ ! $REPLY =~ ^[Yy]$ ]]; then
		exit 0
	fi
fi

for f in ${FILES[@]}; do
	echo "Converting $f.$TYPE to .ogg and .wav"
	if ffmpeg -y -i $f.$TYPE -af "silenceremove=1:0:$T,silenceremove=stop_periods=-1:stop_duration=0.1:stop_threshold=$T" converted/trimmed/wav/$f.wav converted/trimmed/ogg/$f.ogg 1>/dev/null 2>/dev/null; then
		echo "$f.$TYPE trimmed with noice thershold of $T"
		if ffmpeg -y -i $f.$TYPE converted/original/wav/$f.wav converted/original/ogg/$f.ogg 1>/dev/null 2>/dev/null; then
			echo "$f.$TYPE converted"
			mv $f.$TYPE converted
		fi
	else
		echo "$f.$TYPE failed"
	fi
done
