#!/bin/sh
read n
r=0
num=0
while [ $n -gt 0 ]
do
    r=$(( $n % 10 ))
    num=$(( $num * 10 + $r ))
    n=$(( $n / 10 ))
done
echo $num