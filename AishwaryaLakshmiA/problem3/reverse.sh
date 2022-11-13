#!/bin/bash
echo "Enter input number to be reversed"
read n
op=0
while [ $n -gt  0 ];
do
        rem=`expr $n % 10`
        op=`expr $op \* 10 + $rem`
        n=`expr $n / 10`
done
echo "reversed number is: $op"