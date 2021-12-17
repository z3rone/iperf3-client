#!/bin/bash
while true ; do
	while IFS='=' read -r name value ; do
		if [[ $name == 'IPERF3_SERVER_'* ]]; then
			server=$(echo ${!name} | cut -d ":" -f 1)
			port=$(echo ${!name} | cut -d ":" -f 2)
			logfile=$(echo $name | sed 's/IPERF3_SERVER_//')
			echo Run iperf3 for server $server and port $port. Log in $logfile.json
			touch logs/$logfile.json
			result=$(iperf3 -c $server -p $port -J | jq "$IPERF3_JQ")
			old_results=$(sed -e '1,1d' -e '$d' "logs/$logfile.json")
			echo -e '[\n\t'"$old_results"'\n'"$result"',\n]' > logs/$logfile.json
		fi
	done < <(env)
	echo Sleep for $IPERF3_INTERVAL
	sleep $IPERF3_INTERVAL
done
