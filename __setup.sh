#!/bin/bash

function __create_or_update_files {	
	if [ -d "$1" ]; then
		cd "$1";
		chmod +x __update.sh;
		./__update.sh "$2";
		cd ../;
	else
		git clone "https://github.com/PedroCardouzo/""$1"".git";
	fi
}

__create_or_update_files "simplescripts" "$1";
__create_or_update_files "xml_decoder" "$1";