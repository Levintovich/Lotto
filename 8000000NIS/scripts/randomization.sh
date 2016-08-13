#!/bin/bash

# *********************************************************************************
# Randomization process: Generating 6 different numbers [0=<A1<A2<A3<A4<A5<A6<=37] for Lotto
# These numbers should be analized.
# *********************************************************************************


# Parameters for project.
: ${WORKSPACE:=$2}
: ${ANALIZE_SPACE:=${WORKSPACE}/analize}
: ${SCRIPTS:=${WORKSPACE}/scripts}
: ${RESULTS:=${WORKSPACE}/results}

if [ $1 == "Lotto" ]; then
	echo "Lotto randomization"
	#Generating random permutation from 1 to 37
	random_num=`shuf -i 1-37 -n 6 | sort -n`
	echo $random_num

	# Generating extra number
	extra=$(( ( RANDOM % 7 )  + 1 ))
	echo extra=$extra


	#Checking if this random number exists in the file ${RESULTS}/results.txt
	if grep -Fxq "$random_num" ${RESULTS}/results.txt 
	then
		echo This number exists
	else 
		echo This new number
	fi
else
	echo "777 randomization"
	#Generating random permutation from 1 to 70
	random_num=`shuf -i 1-70 -n 17 | sort -n`
	echo $random_num
fi

# Inserting $random_num to array
arr=(`echo ${random_num}`);
array_length=${#arr[@]}

# processing an array: adding 0 to digits < 10 and adding comma
echo "processing array"
i=0
random_num=""
while [ $i -lt $array_length ]; do	
	if [ $1 == "777" -a ${arr[$i]} -lt 10 ]; then
		arr[$i]=0${arr[$i]}
	fi  		
	let i=i+1	
done

# Adding comma
random_num=$( echo ${arr[@]} | sed 's/ /,/g' )
echo "random=$random_num"

# Checking number existing
echo "Checking existence this number"
if grep -q "$random_num" "${RESULTS}/outputfile.csv"; then 
	echo This number exists
	echo "$random_num exists" >> log
	exit 0
else
	echo This is a new number
	echo "$random_num new" >> log
fi






