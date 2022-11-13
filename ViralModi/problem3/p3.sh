#!/bin/bash

#Taking input from user
read -p 'Input: ' num

#We will store the output in this variable
res=0

#While loop
while [ $num -gt 0 ]
do
	res=$(expr $res \* 10)
	temp=$(expr $num % 10)
	res=$(expr $res + $temp)
	num=$(expr $num / 10)
done	

#Printing result
echo "Output: $res"