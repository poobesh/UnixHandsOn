#!/bin/bash
echo "Enter the number to reverse"
read number
reverse=0
s=0

while [ $number -gt 0 ]
do
s=`expr $number % 10`
reverse=`expr $reverse \* 10 + $s`
n=`expr $number / 10`
done
echo "Reverse number is $reverse"


