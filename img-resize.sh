#!/bin/bash
for i in *.JPG; do
	fname="${i%.*}"
	ext=".${i##*.}"
	newname="$fname-640x360$ext"
	convert -resize 640x360 "$i" "$newname"
done
