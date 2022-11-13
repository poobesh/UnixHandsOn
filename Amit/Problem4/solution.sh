#! /bin/bash

#associative array decleration 
declare -A newmap

# function to count each occurance

function count {
	((newmap[$1]++))
}

read -p 'Enter the file name :' fileName

# File do exit or not

if [ -f $fileName ]
then
	echo "File Found"
else
	echo "File Not Found"
	exit 1
fi

# print word by word

while read -ra line;
do
        for word in "${line[@]}";
	do 
		count $word;
	done
done < $fileName

#print key values 

for KEY in "${!newmap[@]}"; do
  echo -n "${newmap[$KEY]} $KEY "
done

