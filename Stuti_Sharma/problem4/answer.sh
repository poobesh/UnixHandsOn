#!/bin/bash
tr -s " " "\n" < animal.txt | grep -v "^$" | sort | uniq -c | sort -n 
