#!/bin/bash
cd $(dirname $0)

# Loop Through Files
for file in *.torrent; do
	# Add Current File To List
	echo "$file" | sed 's/ (.*).torrent/.torrent/g' >> album.list
done

# Loop Through Files (Year)
for file in *.torrent; do
	# Add Current File To List
	echo "$file" | sed 's/ - [0-9][0-9][0-9][0-9] (.*).torrent/.torrent/g' >> year.list
done

# Sort Lists
sort -o album.list album.list
sort -o year.list year.list

# Print Unique List Values
uniq -u album.list > album.list
uniq -u year.list > year.list
