#!/bin/bash
value=`cat sampleFile.txt`
echo "$value" | sed -e 's/ /\n/g' | sort | uniq -c --count
