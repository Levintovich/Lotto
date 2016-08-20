#!/bin/bash



# *********************************************************************************
# Generating number untill the last result
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
		echo "Number $random_num can't be usable" >> ${SCRIPTS}/gen_log
		return 0
	fi
	# It' OK continue to find
}

generate_permutation () {
#############################################################
# Generating random permutation from 1 to 70
###############################################################
	random_num=`shuf -i 1-70 -n 17 | sort -n`
	# Inserting $random_num to array
	arr=(`echo ${random_num}`);
	array_length=${#arr[@]}
	# processing an array: adding 0 to digits < 10 and adding comma
	i=0
	random_num=""
	while [ $i -lt $array_length ]; do	
		if [ ${arr[$i]} -lt 10 ]; then
			arr[$i]=0${arr[$i]}
		fi  		
		let i=i+1	
	done
	# Adding comma
	random_num=$( echo ${arr[@]} | sed 's/ /,/g' )
###################################################################
}

############################################################################
# End Functions
############################################################################

last_result=$( head -n 1 ${RESULTS}/outputfile.csv | awk '{print $3}' )
last_result="${last_result::-1}" # To remove last character
count=0
echo "Starting generation algorithm $date. Finding number $last_result"
echo "Starting generation algorithm $date. Finding number $last_result" > ./gen_log

#############################################################
# Generating random permutation from 1 to 70
###############################################################
generate_permutation

# Checking if generated permutation equals the last_result

while [ $random_num != $last_result ]; do	
	if [ $count -eq "1000" ]; then
		echo "$date was generated $count times. Current number is $random_num"
		echo "$date was generated $count times. Current number is $random_num" >> ./gen_log
		let count=0
	fi
	generate_permutation
	let count=count+1
done

echo "$date Number $last_result is found."
echo "$date Number $last_result is found." >> ./gen_log
echo "Finding the next number...Generating permutation..."

echo "$1 randomization....Please wait..."
for a in `seq 1 500`; do
	${SCRIPTS}/randomization.sh $1 $WORKSPACE
done






