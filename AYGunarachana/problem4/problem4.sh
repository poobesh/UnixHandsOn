sed -e 's/ /\n/g' file1.txt | grep -v '^$' | sort | uniq -c | sort -n
