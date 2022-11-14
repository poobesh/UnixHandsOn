#!/bin/bash
awk '{for(i = 1; i <= NF; i++) {a[$i]++}} END {for(k in a) if(a[k] -gt 0) {print k , a[k]} a[k]=0 }' problem4_input.txt