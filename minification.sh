#!/bin/bash

sudo npm install -g node-minify
sudo apt install --assume-yes gcc shc   

rm -Rf tests-selfmade-project-1-public/*
cp -r secret-tests/* tests-selfmade-project-1-public/
minify(){
	if [ -n "$1" ] ; then
		FILE=$1
		if [ -d "${FILE}" ] ; then
			for filename in $FILE/*; do
				minify "${filename}"
			done
		elif [ -f "${FILE}" ]; then
			if [[ "$FILE" =~ ".js" ]] && [[ ! "$FILE" =~ ".json" ]] ; then
  				node-minify -i "$FILE" -o "$FILE" -c gcc
				if [[ $? != 0 ]] ; then
					echo "MINIFICATION FAILED"
					exit 1
				fi
			elif [[ "$FILE" =~ ".sh" ]] ; then
                #shc -f "${FILE}"
				if [[ $? != 0 ]] ; then
					echo "MINIFICATION FAILED"
					exit 1
				fi
				#rm "${FILE}" "${FILE}.x.c"
			fi
		fi
	fi
}

minify tests-selfmade-project-1-public
exit 0
