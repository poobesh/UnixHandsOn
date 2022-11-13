#!/bin/bash
echo "Enter the number to reverse : "
read num
n=0
while [ $num -gt 0 ]
do
	n=$(expr $n \* 10)
	k=$(expr $num % 10)
	n=$(expr $n + $k)
	num=$(expr $num / 10)
done
echo "Reversed Number is : " $n

