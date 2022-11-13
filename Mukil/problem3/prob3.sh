#!/bin/bash
echo "Input:"
read n
rem=0
res=0

while [ $n -gt 0 ]
do
	rem=$(( $n % 10))
	res=$(( $res * 10 + $rem))
	n=$(( $n / 10))
done

echo "Output: $res" 
#

