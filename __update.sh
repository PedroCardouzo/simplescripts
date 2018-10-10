#!/bin/bash

while getopts 'd' OPT; do
  case "$OPT" in
    'd') DEV='true';
		 echo 'dev mode';
       ;;
    '?') echo "illegal option @ ""$0" >&2
       exit -1
       ;;
  esac
done


if [[ $DEV == 'true' ]]; then
	echo 'no dev branch available yet: pulling from master'
	git pull origin master
else
	git pull origin master
fi
