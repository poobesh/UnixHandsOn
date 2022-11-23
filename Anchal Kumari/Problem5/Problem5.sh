 file="100 CC Records.csv"
{
    read
    while IFS="," read -r f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 f11
do
    IFS='/'
    read -a arr <<< $f8
        if [ ${arr[1]} -gt "`date +"%Y"`" ]
            then output="$f4.active"
        elif [ ${arr[1]} -eq "`date +"%Y"`" ] && [ ${arr[0]} -ge "`date +"%m"`" ]
            then output="$f4.active"
        else
            output="$f4.expired"
        fi
  echo "Card Type Code:$f1" >> "$output"
  echo "Card Type Full Name:$f2" >> "$output"
  echo "Issuing Bank:$f3" >> "$output"
  echo "Card Number:$f4" >> "$output"
  echo "Card Holder's Name:$f5" >> "$output"
  echo "CVV/CVV2:$f6">> "$output"
  echo "Issue Date:$f7" >> "$output"
  echo "Expiry Date:$f8">> "$output"
  echo "Billing Date:$f9">> "$output"
  echo "Card PIN:$f10" >> "$output"
  echo "Credit Limit: "$f11 | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta' | sed 's/ /$/2' | sed 's/$/ USD/'>>"$output"
done
} < "$file"




