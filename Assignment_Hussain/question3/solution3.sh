#!/bin/bash
echo input a number
read num
i=0
while [ $num -gt 0 ]
do
	i=`expr $i \* 10`
	x=`expr $num % 10`
	i=`expr $i + $x`
	num=`expr $num / 10`
done
echo num is $i

