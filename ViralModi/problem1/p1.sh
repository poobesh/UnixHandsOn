#!/bin/bash

#command to print the lines that has the the pattern “july” in all the files in "findPattern" directory
grep -i "july" ./findPattern/*

#command to print the lines that has the the pattern “july” in all the files in same directory
#grep -i "july" *