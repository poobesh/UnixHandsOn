#!/bin/bash
file='100 CC Records.csv'
isActive="notknown"
while IFS="," read -r cardCode cardType issuingBank cardNumber cardName CVV issueDate expiryDate billingDate cardPin creditLimit;do
	currentYear=$(date +'%Y')
	currentMonth=$(date +'%m')
	IFS='/'
	read -ra arr <<< "$expiryDate"

	expiryYear=${arr[1]}
	expiryMonth=${arr[0]}
	

	if [ $currentYear -eq $expiryYear ]
	then 
		if [ $currentMonth -gt $expiryMonth ]
		then
			isActive="expired"
		else
			isActive="active"
		fi
	else
		if [ $currentYear -lt $expiryYear ]
		then
			isActive="active"
		else
			isActive="expired"
		fi
	fi

fileName="$cardNumber"."$isActive.txt"
echo "$fileName"

mkdir -p $cardType/$issuingBank

echo -e "Card Type Code: $cardCode\nCard Type Full Name: $cardType\nIssuing Bank: $issuingBank\nCard Number: $cardNumber\nCard Holder's Name: $cardName\nCVV/CVV2: $CVV\nIssue Date: $issueDate\nExpiry Date: $expiryDate\nBilling Date: $billingDate\nCard Pin: $cardPin\ncreditLimit: $creditLimit" > "$cardType/$issuingBank/$fileName"

done < <(tail -n +2 "$file")


