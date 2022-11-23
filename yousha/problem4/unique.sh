#!/bin/bash
{
echo "tiger bear elephant tiger bear bear"
    
} > animal.txt

sed -e 's/ /\n/g' animal.txt | grep -v '^$' | sort | uniq -c

#sed -e 's/ /\n/g' animal.txt | grep -v '^$' | sort | uniq -c | sort -n  #to sort by frequency