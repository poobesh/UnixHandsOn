#!/bin/bash

#Read input from user
echo "Input a word to search"
read input

#Find thhe count of occurence in file
grep -i -o $input 'animal.txt' | wc -l
