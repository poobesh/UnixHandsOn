#!/bin/bash
usdfunction(){
    usd=`echo $1 | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta' | sed 's/^/$/' | sed 's/$/ USD/'`
}
dirfunction(){
    dir=`echo $1 | sed 's/ /\\ /g'`
}
compare_dates(){
    if [ $1 -gt $(date +%Y) ]
    then
        expiry_check=active
    elif [[ $1 -eq $(date +%Y) && $2 -gt $(date +%m)]]
    then
        expiry_check=active
    else
        expiry_check=expired
    fi            

}
while IFS="," read -r rec_column1 rec_column2 rec_column3 rec_column4 rec_column5 rec_column6 rec_column7 rec_column8 rec_column9 rec_column10 rec_column11 
do
     expiry_yr="${rec_column8:3:6}"
     expiry_mon=$[$((10#{rec_column8:0:2}))]
     compare_dates $expiry_year $expiry_mon
     usdfunction $rec_column11
     dirfunction $rec_column2
     parent_directory=$(echo $rec_column2 | sed 's/ /_/g')
     child_directory=$(echo $rec_column3 | sed 's/ /_/g;t')
     mkdir -p $parent_directory/$child_directory
     cd $parent_directory/$child_directory
     if [ $expiry_check = 'active' ]
     then
        echo "Card Type Code: $rec_column1
        Card Type full name : $rec_column2
        Issuing Bank : $rec_column3
        Card Number : $rec_column4
        Card Holder's Name : $rec_column5
        CVV/CVV2 : $rec_column6
        Issue Date : $rec_column7
        Expiry Date : $rec_column8
        Billing Date : $rec_column9
        Card PIN : $rec_colimn10
        Credit Limit : $usd" > $rec_column4.active
     else
        echo "Card Type Code: $rec_column1
        Card Type full name : $rec_column2
        Issuing Bank : $rec_column3
        Card Number : $rec_column4
        Card Holder's Name : $rec_column5
        CVV/CVV2 : $rec_column6
        Issue Date : $rec_column7
        Expiry Date : $rec_column8
        Billing Date : $rec_column9
        Card PIN : $rec_colimn10
        Credit Limit : $usd" > $rec_column4.expired
     fi
     cd ..
     cd ..
     done < <((tail -n +2 100\ CC\ Records.csv))   
