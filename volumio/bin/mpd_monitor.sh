#!/bin/bash

# Check interval (in seconds)
CHECK_INTERVAL=20
# Define the timeout (in seconds) for no output
TIMEOUT=10

echo "MPD Monitor Service: Starting MPD Monitor Service"
while true; do
    # Get output of mpc command and measure time it takes to respond
    OUTPUT=$(timeout $TIMEOUT mpc)
    
    if [ -z "$OUTPUT" ]; then
        # If there is no output, restart the MPD service
	echo "MPD Monitor Service: MPD Appears to be inactive, restarting" 
        killall -g mpd
        systemctl restart mpd.service
        echo "MPD Monitor Service: MPD restarted due to no mpc output."
    fi

    # Wait for the defined interval before checking again
    sleep $CHECK_INTERVAL
done

