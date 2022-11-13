#!/bin/bash
convertUSD(){ 
    usd=`echo $1 |  sed -e :a -e 's/\(.*[0-9]\)\([0-9]\{3\}\)/\1,\2/;ta' | sed 's/^/$/' | sed 's/$/ USD/'` 
}


assignStatus(){
	if [[ $1 -gt $(date +%Y) ]] 
	then
		status=active
	elif [[ $1 -eq $(date +%Y) && $2 -gt $(date +%m) ]] 
	then
		status=active
	else
		status=expired
	fi 
}

while IFS="," read -r card_type_code card_type_full_name issuing_bank card_number card_holder cvv issue_date expiry_date billing_date card_pin card_limit
do

    convertUSD $card_limit

	year="${expiry_date:3:6}" 
	month=$[$((10#${expiry_date:0:2}))] #had to forcefully change to base 10 since shell kept reading values like 08 as octal
	assignStatus year month 

 
    parentDir=$(echo $card_type_full_name |  sed 's/ /_/g') 
	childDir=$(echo $issuing_bank | sed 's/ /_/g;t')
	mkdir -p $parentDir/$childDir
	cd  $parentDir/$childDir
	
    echo "Card Type Code : $card_type_code
    Card Type Full Name : $card_type_full_name
    Issuing Bank : $issuing_bank
    Card Number : $card_number
    Card Holder's Name : $card_holder
    CVV/CVV2 : $cvv
    Issue Date : $issue_date
    Expiry Date : $expiry_date
    Billing Date : $billing_date
    Card PIN : $card_pin
    Credit Limit : $usd" > $card_number.$status 
	
			
cd ..
cd ..

done < <((tail -n +2 100\ CC\ Records.csv))