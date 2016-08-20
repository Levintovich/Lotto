#!/bin/bash

# Parameters for project.
: ${WORKSPACE:=$2}
: ${ANALIZE_SPACE:=${WORKSPACE}/analize}
: ${SCRIPTS:=${WORKSPACE}/scripts}
: ${RESULTS:=${WORKSPACE}/results}

last_result=$( head -n 1 ${RESULTS}/outputfile.csv | awk '{print $3}' )
echo "last_result=$last_result"
last_result="${last_result::-1}" 
echo "string length=${#last_result}"

random_num="05,10,13,17,25,30,38,43,45,46,50,52,53,61,65,66,69"
echo "string length=${#random_num}"
count=0
while [ $random_num != $last_result ]; do
	if [ $count -lt "10" ]; then	
		echo "Not equal"
		let count=count+1
	else
		last_result="$(echo $random_num)"
	fi
done

echo "String are equal"
