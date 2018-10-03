#!/bin/bash

/opt/c7supervisor/bin/docker-replacefiles.sh

# run before-supervisor.d script
if [ -d /docker-settings/before-supervisor.d ] && [ $(ls -A /docker-settings/before-supervisor.d) ]; then
    for shellfile in $(find /docker-settings/before-supervisor.d -type f);
        do
            echo "Before supervisor run : $shellfile"
            eval $shellfile
    done
fi

# run after-supervisor.d script

/opt/c7supervisor/bin/docker-after-supervisor.sh &

exec "$@"