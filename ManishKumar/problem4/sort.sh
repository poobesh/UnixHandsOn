#!/bin/bash
awk '{for(w=1;w<=NF;w++) print $w}' animal.txt | sort | uniq -c | sort -nr