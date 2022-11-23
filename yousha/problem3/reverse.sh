#!/bin/bash

reverse_num () {
	num=0
	while [ $n -gt 0 ]
	do
	num=$(expr $num \* 10)
	k=$(expr $n % 10)
	num=$(expr $num + $k)
	n=$(expr $n / 10)
	done
	echo Reverse: $num
}

echo enter n
read n
if [[ ! $n =~ ^[0-9]+$ ]] ; then
    echo "Not an integer"
    exit
fi
reverse_num $n

