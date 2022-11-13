#!/bin/bash
input="Bank_Records.csv"
OLDIFS=$IFS
currentdate=$(date +"%Y%M") 
while IFS=',' read col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11
do
    year=${col8:3:4}
    month=${col8:0:2}
    expirydate=$year$month
    #echo $exp
    if [ $expirydate -gt $currentdate ]
    then
        accstatus="active"
    else
        accstatus="expired"
    fi 
mkdir -p "$col2"
    cd "$col2"
    mkdir -p "$col3"
    cd "$col3"
    var=`echo $col11 | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta' | sed 's/^/$/' | sed 's/$/ USD/'` 
    echo "Card Type Code : $col1
Card Type Full Name : $col2
Issuing Bank : $col3
Card Number : $col4
Card Holder Name : $col5
CVV/CVV2 : $col6
Issue Date : $col7
Expiry Date : $col8
Billing Date : $col9
Card PIN : $col10
Credit Limit : $var" > $col4.$accstatus
    cd ..
    cd ..
done < <(tail -n +2 $input)
IFS=$OLDIFS