#!/bin/bash
echo "enter number:"
read n
echo "number entered: $n"
rem=0
rev=0
while [ $n -gt 0 ]
do
	rem=$(( $n % 10 ))
	rev=$(( $rev * 10 + $rem ))
	n=$(( $n / 10 ))
done
echo "reverse of given number is: $rev"
