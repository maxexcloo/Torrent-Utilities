#!/bin/bash
cd $(dirname $0)

# Loop Through Files
for file in torrents/*.torrent
do
	# Print Torrent Metadata Name To File
	python2 torrentinfo.py "$file" >> list.txt
	# Echo File Name
	echo "$file"
done
