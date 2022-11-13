#!/bin/usr
echo "enter word that has to be searched"
read word
output=$ grep -o -i $word 'prob5test.txt' | wc -l
echo $ouput
