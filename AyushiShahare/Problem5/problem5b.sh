#!/bin/bash

find . -type f \( -name "*.active" -o -name "*.expired" \) | cut -c 3- | cat>filename_collection

file_size=`wc -l 100\ CC\ Records.csv | awk '{ print $1 }'`

first_file=`awk '(NR==1)' filename_collection`

awk -F: '{print $1}' $first_file | paste -s -d, - | cat >> output.csv

for (( i=0; i<$file_size; i++ )); do
  index=$((i+1))
  data=`awk '(NR=='$index')' filename_collection`
  awk -F: '{print $2}' $data | sed 's/,//g' | paste -s -d, - | cat >> output.csv
done

rm -r filename_collection