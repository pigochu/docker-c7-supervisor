#!/bin/bash

# import env
# for e in $(tr "\000" "\n" < /proc/1/environ); do
#        eval "export $e"
# done

envnames=$(env | sed 's/=/ /g' | awk '{print "${"$1"}"}' | paste -sd ':')

# copy replcaefiles
cp -rf --no-preserve=mode,ownership,xattr /root/.replace-files/* /

# do template replace
for sourcefile in $(find /root/.template-files -type f);
    do
        targetfile=$(echo "$sourcefile" | cut -c 22-)
        echo "template : $sourcefile to $targetfile"
		envsubst $envnames < $sourcefile > $targetfile
done

