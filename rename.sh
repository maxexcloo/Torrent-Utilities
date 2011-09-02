#!/bin/bash
# A simple script that goes through a list of torrents and renames them to the names listed in their metadata.

cd $(dirname $0)
FILES=Music/*

for f in $FILES
do
	python2 torrentinfo.py "$f" >> list.txt
	echo "$f"
done
