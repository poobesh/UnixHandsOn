#! /bin/bash
read -p 'enter the number : ' num
orignalNum=$num
lastDigit=0
result=0

#code to check valid input 
#src https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash

re='^[0-9]+$'
if ! [[ $num =~ $re ]] ; then
   echo "error: Not a number" >&2; exit 1
fi

#if input is valid

while (( num > 0))
do	
	lastDigit=$((num % 10 ))
	result=$(((result * 10) + lastDigit))
	num=$((num / 10))

done

echo Reverse of number $orignalNum is $result
