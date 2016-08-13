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


# Functions

# checking_existence ()
###########################################################################
# Checks if substring is existing at the result file.
# If substring is existing, program will stop to find a next random value
# $1 - Entering string
# $2 - starting string position
# $3 - ending string position
############################################################################
checking_existence () {	
	subnum=$( echo ${1:$2:$3} )
	if grep -q "$subnum" "${RESULTS}/outputfile.csv"; then		
		echo "Number $random_num can't be usable" >> ${SCRIPTS}/logfile
		exit 0
	fi
	# It' OK continue to find
}

############################################################################
# End Functions
############################################################################

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
	#Generating random permutation from 1 to 70
	random_num=`shuf -i 1-70 -n 17 | sort -n`
fi

# Inserting $random_num to array
arr=(`echo ${random_num}`);
array_length=${#arr[@]}

# processing an array: adding 0 to digits < 10 and adding comma
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

# Checking number existing
if grep -q "$random_num" "${RESULTS}/outputfile.csv"; then 
	echo "Number $random_num exists"
	exit 0
else	
	echo "New number $random_num"  >> ${SCRIPTS}/logfile
fi

# Checking existing subnumbers
if [ $1 == "777" ]; then	
	for a in `seq 0 3 36` ; do checking_existence $random_num $a 14; done	
fi

echo "You can use number $random_num Good Luck!" 
echo "You can use number $random_num Good Luck!" >> ${SCRIPTS}/logfile









