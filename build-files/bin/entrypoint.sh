#!/bin/bash

/opt/c7supervisor/bin/docker-replacefiles.sh

# run beford.d script
if [ $(ls -A /docker-settings/before.d) ]; then
	for shellfile in $(find /docker-settings/before.d -type f);
		do
			echo "run file: $shellfile"
			eval $shellfile
	done
fi




# run supervisor



# run after.d

exec "$@"