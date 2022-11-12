#!/bin/bash
file='100 CC Records.csv'
nowMonth=$(date +"%m")
nowYear=$(date +"%Y")

while IFS="," read -r cardCode cardName issuingBank cardNumber cardHolderName cvv issueDate expiryDate billingDate cardPIN creditLimit
do
	if [ -d $cardName ]
	then
		if [ -d $cardName/$issuingBank ]
		then
			echo -e "Already Exists\n"
		else
			mkdir $cardName/$issuingBank
		fi
	else
		mkdir $cardName
		mkdir $cardName/$issuingBank
	fi

	IFS="/"
	read -ra arr <<< "$expiryDate"
	expiryMonth="${arr[0]}"
	expiryYear="${arr[1]}"
	isActive='idk'
	
	if [ $expiryYear == $nowYear ]
	then
		if [ $expiryMonth \> $nowMonth ]
		then
			isActive='active'
		else
			isActive='expired'
		fi
	elif [ $expiryYear \> $nowYear ]
	then
		isActive='active'
	elif [ $expiryYear \< $nowYear ]
	then
		isActive='expired'
	fi

	fileName="$cardNumber.$isActive.txt"
	
	echo -e "Card Type Code: $cardCode\nCard Type Full Name: $cardName\nIssuing Bank: $issuingBank\nCard Number: $cardNumber\nCard Holder's Name: $cardHolderName\nCVV/Cvv2: $cvv\nIssue Date: $issueDate\nExpiry Date: $expiryDate\nBilling Date: $billingDate\nCard PIN: $cardPIN\nCredit Limit: $ $creditLimit USD\n" > "$cardName/$issuingBank/$fileName"


done < <(tail -n +2 "$file")
