#!/bin/bash

echo "Number of Words:"

grep -o "[A-Z,a-z]*" temp.txt | sort | uniq -c
