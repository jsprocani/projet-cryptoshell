#!/bin/bash

rep="${1:-.}"
locked_files=$(find "$rep" -type f -name "*.locked" 2>/dev/null | wc -l)
ransom_files=$(find "$rep" -type f -name "RANSOM_NOTE.txt" 2>/dev/null | wc -l)
hidden_files=$(find "$rep" -type f \( -name ".cs_count" -o -name ".cryptoshell_key" \) 2>/dev/null | wc -l)
suspect_patterns=$(grep -rl "xor\|locked\|RANSOM" "$rep" --include="*.sh" 2>/dev/null | wc -l)

echo "Fichiers .locked : $locked_files"
echo "RANSOM_NOTE.txt : $ransom_files"
echo "Fichiers cachés : $hidden_files"
echo "Motifs suspects: $suspect_patterns"
