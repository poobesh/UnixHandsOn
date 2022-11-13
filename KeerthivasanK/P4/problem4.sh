#!/bin/bash
echo "Word Count:"

grep -o "[A-Z,a-z]*" animat.txt | sort | uniq -c
