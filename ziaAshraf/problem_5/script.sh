#!/bin/bash
while read -r num name; do
  [[ $name == "08/2023" ]] && printf "%s\n" "$num"
done < "extractedData.csv"


