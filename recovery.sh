#!/bin/bash

fkey=$(find -type f -name ".cryptoshell_key" 2> /dev/null | head -n 1)
key=$(head -c 16 "$fkey" 2> /dev/null)

if [ -n "$key" ]
then
	
	source xor_helper.sh
	
	while IFS= read -r -d '' file
	do
		xor_file "$file" "${file%.locked}" $key
		rm -f "$file" 2> /dev/null
	done < <(find -type f -name "*.locked" -print0 2> /dev/null)
	
fi

find -type f \( -name "RANSOM_NOTE.txt" -o -name ".cs_count" -o -name ".cryptoshell_key" \) -delete 2> /dev/null

