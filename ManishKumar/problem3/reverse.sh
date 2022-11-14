#!/bin/bash
reverse(){
    num=0
    while [ $n -gt 0 ]
    do
        num=$(expr $num \* 10)
        k=$(expr $n % 10)
        num=$(expr $num + $k)
        n=$(expr $n / 10)
done
}
echo enter number
read n
reverse n
echo reverse number is $num