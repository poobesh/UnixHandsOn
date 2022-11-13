#!/bin/bash
file=Records.csv
ifs1=$IFS
date=$(date +"%Y%M")
while IFS="," read cardTypeCode cardTypeFullName issuingBank cardNumber cardHolderName cvv issueDate expiryDate billingDate cardPin creditLimit
do
	ex_yr=${expiryDate:3:4}
	ex_month=${expiryDate:0:2}
	exp=$ex_yr$ex_month
	if [ $exp -gt $date ]
	then
		status="active"
	else
		status="expired"
	fi
	mkdir -p "$cardTypeFullName"
	cd "$cardTypeFullName"
	mkdir -p "$issuingBank"
	cd "$issuingBank"
	var=`echo $creditLimit | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta' | sed 's/^/$/' | sed 's/$/USD/'`
	echo "Card Type Code : $cardTypeCode
Card Type Full Name : $cardTypeFullName
Issuing Bank : $issuingBank
Card Number : $cardNumber
Card Holder Name : $cardHolderName
CVV/CVV2 : $cvv
Issue Date : $issueDate
Billing Date : $billingDate
Card PIN : $cardPin
Credit Limit : $var" > $cardNumber.$status
	cd..
	cd..
done < (tail -n +2 Records.csv)
IFS=$ifs1
