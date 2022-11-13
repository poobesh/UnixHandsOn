#!/bin/bash
declare -a ar
headersArr=("Card Type Code" "Card Type Full Name" "Issuing Bank" "Card Number" "Card Holder's Name" "CVV/CVV2" "Issue Date" "Expiry Date" "Billing Date" "Card PIN" "Credit Limit")
headerRow=""
for i in "${headersArr[@]}"
do
        headerRow+="\"$i\","
done

echo $headerRow >> credit_card_records.csv

write_csv(){
    arr=("$@")
    #echo $arr
    row=""
    for i in "${arr[@]}";
    do
            #echo "$i"
            row+="\"$i\","
    done
    echo $row >> credit_card_records.csv
    #echo \"$1\",\"$2\",\"$3\",\"$4\" >> credit_card_records.csv
}

headDir="./Credit_Card_Records/"
for d in "$headDir"*/
do
        echo $d
        for e in "$d"*/
        do
                echo $e
                for file in "$e"*
                do
                        cd "$e"
                        f="$(basename "$file")"
                        echo $f
                        n=0
                        while read line
                        do
                                word=$(cut -d ":" <<< $line -f2)
                                ar[$n]=$word
                                n=$((n+1))
                        done < $f
                        cd ..
                        cd ..
                        cd ..
                write_csv "${ar[@]}"
                echo "${ar[@]}"
                done

        done
done


