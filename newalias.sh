#!/bin/bash


if [[ "$#" -ge 2 ]]; then
	NEW_ALIAS="$1";
	ALIAS_ACTION="$2";
else
	echo 'provide new alias command: '
	NEW_ALIAS=$(cat);
	echo 'provide code to be executed: '
	ALIAS_ACTION=$(cat);
fi

echo alias "$NEW_ALIAS"'='\'"$ALIAS_ACTION"\' >> /mnt/c/Users/I866021/Documents/Incidents/scripts/config_text.txt # ~/.bashrc