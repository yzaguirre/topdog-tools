#!/bin/bash
for f in $(find . -name '*.camrec'); do
    #wget $line -O $file
    #echo camrecfile $f
    #echo avifile ${f%.*}.avi
    #7z x $f *.avi -r -so > ${f%.*}.avi
    mp4file=${f%.*}.mp4
    if [ ! -f $mp4file ]
    then
    	7z x $f *.avi -r -so | ffmpeg -i - -c:v libx264 -crf 23 $mp4file
    fi
    #ffprobe ${f%.*}.avi 2>&1 | grep Duration | awk '{print $2;}'
done
