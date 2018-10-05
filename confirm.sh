#!/bin/bash
RED='\033[0;31m';
GREEN='\033[0;32m'; 
NO_COLOR='\033[0m';
list="$(cat)";
IFS=';'
for filename in $list
do
	mv '/mnt/c/Users/I866021/Documents/Incidents/'"$filename" '/mnt/c/Users/I866021/Documents/Incidents/confirmed/' 2>/dev/null;
	result=$?
	if [ "$result" = 0 ];then
		echo -e  "${GREEN}"$filename;
	else
		echo -e "${RED}"$filename;
	fi
done
