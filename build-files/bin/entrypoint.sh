#!/bin/bash

# run init
if [ -d /opt/c7supervisor/etc/init.d ] && [ $(ls -A /opt/c7supervisor/etc/init.d) ]; then
    for shellfile in $(find /opt/c7supervisor/etc/init.d -type f);
        do
            if [ -x "$shellfile" ]; then
                echo "c7supervisor init run : $shellfile"
                eval $shellfile
            fi
    done
fi


/opt/c7supervisor/bin/docker-replacefiles.sh
# run before-supervisor.d script
if [ -d /docker-settings/before-supervisord.d ] && [ $(ls -A /docker-settings/before-supervisord.d) ]; then
    for shellfile in $(find /docker-settings/before-supervisord.d -type f);
        do
            if [ -x "$shellfile" ]; then
                echo "Before supervisor run : $shellfile"
                eval $shellfile
            fi
    done
fi

# run after-supervisor.d script

/opt/c7supervisor/bin/docker-after-supervisord.sh &

exec "$@"