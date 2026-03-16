#!/bin/bash

key=$(head -c 16 .cryptoshell_key 2> /dev/null)
file=$(find -type f -name "*.locked" | head -n 1)

if [ -z "$key" ] || [ -z "$file" ]
then
	exit 1
fi

source xor_helper.sh
xor_file "$file" "${file%.locked}" $key
rm -f "$file"
