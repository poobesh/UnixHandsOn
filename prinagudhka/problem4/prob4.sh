#!/bin/bash
declare -A words
file="animal.txt"
echo "bear elephant monkey tiger elephant elephant elephant tiger elephant elephant monkey" > "animal.txt";
while read line
do
    noOfWords="$(wc -w <<< $line)"
    for((i=1;i<=$noOfWords;i++))
    do
        word=$(cut -d " " <<< $line -f$i)
        if [[ ${!words[@]} =~ $word ]]
        then
            words[$word]=$(( ${words[$word]} + 1 ))
        else
            words[$word]=1
        fi
    done
done < $file
output=""
for key in ${!words[@]}
do
        output+="$key ${words[$key]} "
done
echo $output

