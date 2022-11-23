#!/bin/bash

#Take input from file
echo "Input a number"
read input

output=0
#Reverse the digits of the input number
while [ $input -gt 0 ]
do
	rem=`expr $input % 10`
	output=`expr $output \* 10 + $rem`
	input=`expr $input / 10`
done

#Printing the output
echo "Output : $output"
