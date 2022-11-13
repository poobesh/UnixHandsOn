#!/bin/bash
read -p "Enter the number to reverse: " n
t=0
while [ $n -ne 0 ]; do
temp=`expr $n % 10 `
t=`expr $t \* 10 + $temp `
n=`expr $n / 10 `
done
echo "Reversed Number is: $t"
