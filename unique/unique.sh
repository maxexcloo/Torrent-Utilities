#!/bin/bash
cd $(dirname $0)

# Remove Old Lists
rm list

# Loop Through Files
for file in *.torrent; do
	# Add Current File To List
	echo "$file" | sed 's/ (.*).torrent/.torrent/g' >> list
	# Add Current File To List
	#echo "$file" | sed 's/ - [0-9]* (.*).torrent/.torrent/g' >> list
done

# Sort Lists
sort -f -o list list

# Print Unique List Values
uniq -i -u list

# Remove Old Lists
rm list
