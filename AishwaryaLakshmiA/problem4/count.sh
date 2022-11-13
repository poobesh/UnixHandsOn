#!/bin/bash
cat sample.txt | tr ' ' '\n' | sort | uniq -c | awk '{print $2 "  " $1}'