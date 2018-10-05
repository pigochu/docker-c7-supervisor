#!/bin/bash

# import env
# for e in $(tr "\000" "\n" < /proc/1/environ); do
#        eval "export $e"
# done

envnames=$(env | sed 's/=/ /g' | awk '{print "${"$1"}"}' | paste -sd ':')

# copy replcace-files
if [ -d /docker-settings/replace-files ] && [ $(ls -A /docker-settings/replace-files) ]; then
	echo "replace file"
    cp -rf --no-preserve=mode,ownership,xattr /docker-settings/replace-files/* /
fi

# do template replace
if [ -d /docker-settings/template-files ] && [ $(ls -A /docker-settings/template-files) ]; then

    for sourcefile in $(find /docker-settings/template-files -type f);
        do
            targetfile=$(echo "$sourcefile" | cut -c 22-)
            echo "replace template : $sourcefile to $targetfile"
            envsubst $envnames < $sourcefile > $targetfile
    done

fi