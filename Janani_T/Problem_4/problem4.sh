awk '{for(i = 1; i <= NF; i++) print $i}' ~/animal.txt | sort | uniq -c | sort -nr
