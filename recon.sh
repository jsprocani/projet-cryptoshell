#!/bin/bash

rep="${1:-.}"

total_files=0
total_size=0

printf "%-20s %-20s %-20s %s\n" "fichier" "chemin" "taille en octets" "date de modification"

if [ -f "targets.list" ]
then
	rm -f targets.list
fi

while IFS= read -r -d '' file
do

	size=$(stat --format %s "$file")
	modif=$(stat --format %y "$file")
	
	total_files=$(($total_files+1))
	total_size=$(($total_size+$size))
	
	printf "%-20s %-20s %-20s %s\n" "$(basename "$file")" "$(dirname "$file")" "$size" "$modif"
	
	echo "$file" >> targets.list
	
done < <(find "$rep" -type f \( -name "*.txt" -o -name "*.dat" \) -print0)

echo "Nombre total de fichiers: $total_files"
echo "Taille totale: $total_size"
