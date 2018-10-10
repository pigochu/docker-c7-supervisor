#!/bin/bash

# import env
# for e in $(tr "\000" "\n" < /proc/1/environ); do
#        eval "export $e"
# done

envnames=$(env | sed 's/=/ /g' | awk '{print "${"$1"}"}' | paste -sd ':')

# copy replcace-files
if [ -d /docker-settings/replace-files ] && [ $(ls -A /docker-settings/replace-files) ]; then
	echo "c7-supervisor detected /docker-settings/replace-files has files"
    cp -rf --no-preserve=mode,ownership,xattr /docker-settings/replace-files/* /
	echo "c7-supervisor has processed replace files"
fi

# do template replace
if [ -d /docker-settings/template-files ] && [ $(ls -A /docker-settings/template-files) ]; then
	echo "c7-supervisor detected files in /docker-settings/template-files"
    for sourcefile in $(find /docker-settings/template-files -type f);
        do
			# cut -c 32- : 32 is len("docker-settings/template-files")+1
            targetfile=$(echo "$sourcefile" | cut -c 32-)
            envsubst $envnames < $sourcefile > $targetfile
            echo "c7-supervisor has processed template : $sourcefile to $targetfile"
    done

fi