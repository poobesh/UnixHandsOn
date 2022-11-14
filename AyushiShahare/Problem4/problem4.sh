#!/bin/sh
awk '{for(i = 1; i <= NF; i++) {a[$i]++}} END {for(j in a) if(a[j] != 0) {print  j, a[j]}}' animal.txt