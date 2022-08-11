#!/bin/bash

raw="$(vcgencmd measure_temp | sed -E 's/.*=([0-9.]*).*/\1/')"
temperature_cpu=$(echo "$raw" | bc -l)

#when I tested
testnr=10
test=$(bc -l <<<"${temperature_cpu}+${testnr}")


overheat=80
dangerous=83
normal=55

shutdown=false
start_over=false

until false
do
	
	if (( $(echo "$temperature_cpu > $dangerous" |bc -l) ));
	then
		sudo poweroff
		shutdown=true
	fi

	if (( $(echo "$temperature_cpu > $overheat" |bc -l) ));
	then 
		ps -aux | grep Popcat_code.sh
		killall Popcat_code.sh
	
		until (( $(echo "$temperature_cpu < $normal" |bc -l) ));
		do
		
			if (( $(echo "$temperature_cpu > $dangerous" |bc -l) ));
			then
				sudo poweroff
				shutdown=true
				
			fi
			start_over=true
		done
		
		if [ $start_over = true ]
		then
			./Popcat_code.sh
		fi
	start_over=false
		
	fi
sleep 0.1
done 


