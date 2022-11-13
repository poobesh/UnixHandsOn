file="100 CC Records.csv"
{
    read
    while IFS="," read -r c1 c2 c3 c4 c5 c6 c7 c8 c9 c10 c11
do
    IFS='/' 
    read -a arr <<< $c8
        if [ ${arr[1]} -gt "`date +"%Y"`" ]
            then output="$c4.active"
        elif [ ${arr[1]} -eq "`date +"%Y"`" ] && [ ${arr[0]} -ge "`date +"%m"`" ]
            then output="$c4.active"
        else 
            output="$c4.expired"
        fi
  echo "Card Type Code:$c1" >> "$output"
  echo "Card Type Full Name:$c2" >> "$output"
  echo "Issuing Bank:$c3" >> "$output"
  echo "Card Number:$c4" >> "$output"
  echo "Card Holder's Name:$c5" >> "$output"
  echo "CVV/CVV2:$c6">> "$output"
  echo "Issue Date:$c7" >> "$output"
  echo "Expiry Date:$c8">> "$output"
  echo "Billing Date:$c9">> "$output"
  echo "Card PIN:$c10" >> "$output"
  echo "Credit Limit: "$c11 | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta' | sed 's/ /$/2' | sed 's/$/ USD/'>>"$output"
done
} < "$file"

