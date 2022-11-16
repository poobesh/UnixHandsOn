tr -s " " "\n" < Names.txt | grep -v "^$" | sort | uniq -c | sort -n
