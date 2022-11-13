#!/bin/bash

echo "Enter the no. to be reversed:"
read n


r=0
rev=0
echo "The original no:$n"
while [ $n -ne 0 ];
do
	r=$(($n%10))
	rev=$((($rev*10)+$r))
	n=$(($n/10))
done

echo "The reversed no:$rev"
