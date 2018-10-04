#!/bin/bash
# run after-supervisord.d script

loop=1
backoff=0

# check supervisord running process status
while [ "$loop" == "1" ]
do

	sleep 1
	loop=0
	
    for status in $(supervisorctl status | awk '{print $2}');
        do
			
			echo "Check supervisord Status : $status"
			if [ "$status" == "STARTING" ]; then
				loop=1
				break
			elif [ "$status" == "BACKOFF" ]; then
				loop=1
				backoff=$((backoff+1))
				break
			fi
    done
	

	if [ "$backoff" -gt "10" ]; then
		loop=0
	fi
	
done



if [ -d /docker-settings/after-supervisord.d ] && [ $(ls -A /docker-settings/after-supervisord.d) ]; then
    for shellfile in $(find /docker-settings/after-supervisord.d -type f);
        do
            echo "After supervisor run : $shellfile"
            eval $shellfile
    done
fi
