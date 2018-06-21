#!/bin/bash
filename=$HOME/downloads/dl.txt
cd $HOME/downloads
while IFS=+ read name url
do
    wget -O "$name" "$url"
done < "$filename"
mv $filename $HOME/documents/past_dl/dl_`date +'%F_%H.%M.%S'`.txt
