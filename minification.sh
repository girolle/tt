#!/bin/bash

sudo npm install -g google-closure-compiler
#sudo npm install -g node-minify

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
  				google-closure-compiler --module_resolution="NODE" --js="$FILE" --js_output_file="$FILE"
				# node-minify -i "$FILE" -o "$FILE" -c gcc
				if [[ $? != 0 ]] ; then
					echo "MINIFICATION FAILED"
					exit 1
				fi
			fi
		fi
	fi
}

minify tests-selfmade-project-1-public
exit 0
