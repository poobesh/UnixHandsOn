#!/bin/sh
echo "Enter a number"
read num
rem=0
rev=0
while [ $num -gt 0 ]
do
    rem=$(( $num % 10 ))
    rev=$(( $rev * 10 + $rem ))
    num=$(( $num / 10 ))
done
echo "The reverse of the given number is $rev"
