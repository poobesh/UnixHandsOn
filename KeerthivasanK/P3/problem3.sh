#!/bin/bash
echo "Enter the input:"
read n

echo "Original Number:$n"

r=0;
rev=0;
while ((n!=0))
do
	r=$(($n%10))
	rev=$(($rev*10+$r))
	n=$(($n/10))
done
re=$rev;
echo "The Reversed Number is:$re"
