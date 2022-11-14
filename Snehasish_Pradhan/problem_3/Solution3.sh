#!/bin/bash

echo Enter the number-
read num
rev=0
temp=0
while [ $num -gt 0 ]
do
	temp=`expr $num % 10`
	rev=`expr $rev \* 10 + $temp`
	num=`expr $num / 10`
done
echo reverse number is $rev

