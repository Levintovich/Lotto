#!/bin/bash

#*************************************************************************
# This program downloads loto results in CSV format,
# 
# Programth checks with the sophistcated algorithm if this number exists.
# Input parameter $1 = [Lotto | 777]
#*************************************************************************

# Parameters for project.
: ${WORKSPACE:=`pwd`}
: ${ANALIZE_SPACE:=${WORKSPACE}/analize}
: ${SCRIPTS:=${WORKSPACE}/scripts}
: ${RESULTS:=${WORKSPACE}/results}

#Download loto results from website
curl -o ${WORKSPACE}/$1 http://www.pais.co.il/$1/Pages/last_Results.aspx?download=1
cp ${WORKSPACE}/$1 ${RESULTS}/outputfile.csv # Copy original file to RESULTS space.

# ************************************************************************************
# Replacing using SED
# **************************************************************************************
if [ $1 == "Lotto" ]; then
	# Processing for Lotto results
	echo "Processing 777"
	sed -i ${RESULTS}/outputfile.csv -e '1d' 			# To remove 1-st line
	sed -i ${RESULTS}/outputfile.csv -e 's/"//g'		# To remove all " in the file
	sed -i ${RESULTS}/outputfile.csv -e 's/.\{5\}$//'	# To remove 5 last characters from the file
	sed -i ${RESULTS}/outputfile.csv -e 's/,/| /2'		# To replace 2-nd , to |
	sed -i ${RESULTS}/outputfile.csv -e 's/,/| /7'		# To replace 7-th , to |
	sed -i ${RESULTS}/outputfile.csv -e 's/,/ /1'		# To replace 1-st , to |
	sed -i ${RESULTS}/outputfile.csv -e '|/,/ /g'		# To replace , to space

	cat ${RESULTS}/outputfile.csv | awk '{print $3}' > ${RESULTS}/temp  #to detect result
	awk '($1 > 2107)' ${RESULTS}/outputfile.csv
	sed -i ${RESULTS}/temp -e 's/,/ /g' # To replace comma to space
	sed -i ${RESULTS}/temp -e 's/|//g'  # To remove |
	awk '($6 < 38 ) ' ${RESULTS}/temp > ${RESULTS}/results.txt # to remove numbers > 37
	rm -rf ${RESULTS}/temp
else
	echo "Processing 777"
	sed -i ${RESULTS}/outputfile.csv -e '1d' 			# To remove 1-st line
	sed -i ${RESULTS}/outputfile.csv -e 's/"//g'		# To remove all " in the file
	sed -i ${RESULTS}/outputfile.csv -e 's/,/ /19'		# To remove 19-th ,
	sed -i ${RESULTS}/outputfile.csv -e 's/ [0-9]*//g'	# To remove last row
	sed -i ${RESULTS}/outputfile.csv -e 's/,/| /1'		# To replace 1-st coma to |
	sed -i ${RESULTS}/outputfile.csv -e 's/,/| /1'		# To replace 1-st coma to |
fi


# *********************************************************************************
# Randomization process: Generating 6 different numbers [0=<A1<A2<A3<A4<A5<A6<=37]
# These numbers should be analized.
# *********************************************************************************

${SCRIPTS}/randomization.sh $1


