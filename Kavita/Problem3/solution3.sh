#!/bin/bash

reverse()
{
	sd=0
	rev=0
	while [ $num -gt 0 ]
	do
		sd=$(( $num % 10 ))
		rev=`expr $rev \* 10 + $sd` 
		num=$(( $num / 10 ))
	done
	
	echo "Reverse of the entered number : $rev"
}

echo "Enter a number : " | tr '\n' ' ' 
read num

reverse $num


