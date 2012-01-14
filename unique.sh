#!/bin/bash
cd $(dirname $0)

# Loop Through Files
for file in *.torrent; do
	# Add Current File To List
	echo "$file" | sed 's/ (.*).torrent/.torrent/g' >> list.album
done

# Loop Through Files (Year)
for file in *.torrent; do
	# Add Current File To List
	echo "$file" | sed 's/ - [0-9][0-9][0-9][0-9] (.*).torrent/.torrent/g' >> list.year
done

# Sort Lists
sort -o list.album list.album
sort -o list.year list.year

# Print Unique List Values
uniq -u list.album > list.album
uniq -u list.year > list.year
