#!/bin/bash
echo "  Count Word"
grep -o "[A-Z,a-z]*" t1.txt | sort | uniq -c
