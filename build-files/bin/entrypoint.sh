#!/bin/bash

/opt/c7supervisor/bin/docker-replacefiles.sh

# run before-supervisor.d script
if [ -d /docker-settings/before-supervisord.d ] && [ $(ls -A /docker-settings/before-supervisord.d) ]; then
    for shellfile in $(find /docker-settings/before-supervisord.d -type f);
        do
            echo "Before supervisor run : $shellfile"
            eval $shellfile
    done
fi

# run after-supervisor.d script

/opt/c7supervisor/bin/docker-after-supervisord.sh &

exec "$@"