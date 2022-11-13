echo "Enter filename:"
read filename
cat $filename | tr  -s ' ' '\n'  | sort | uniq -c | sort  -r| awk '{print $2, $1}'