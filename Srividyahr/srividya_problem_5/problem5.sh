#!/bin/bash
file='100 CC Records.csv'
status="notKnown"
IFS=','
while read CardTypeCode CardTypeFullName IssuingBank CardNumber CardHoldersName CVV IssueDate ExpiryDate BillingDate CardPIN CreditLimit
do
	echo "CN: $CardNumber"
	# echo "ED: $ExpiryDate"
	expiredDateNew=$(date -d "${ExpiryDate:0:2}/01/${ExpiryDate:3:7} +1 month -1 day" "+%s")
	currentDate=`date +%s`
	# echo "expired date new: $expiredDateNew"
	# echo "system date: $currentDate"

	dateDiff=$((($expiredDateNew - $currentDate) / 86400))

	# echo "date difference: $dateDiff"
	if (($dateDiff < 0)) 
	then
		#touch "$CardNumber.expired"
		status = "expired"
	#	echo -e "Card Type Code:" >
	else
		#touch "$CardNumber.active"
		status = "active"
	fi

	fileName = "$CardNumber.$status"."txt"
	echo "$fileName"
	mkdir -p $cardTypeFullName/$IssuingBank
	echo -e "Card Type Code: $cardTypeCode\nCard Type FullName: $cardTypeFullName\nIssuingBank: $issuingBank\nCard Number: $cardNumber\nCard Holder's Name: $CardHoldersName\nCVV/Cvv2: $CVV\nIssue Date: $issueDate\nExpiry Date: $expiryDate\nBilling Date: $billingDate\nCard PIN: $cardPIN\nCredit Limit: $creditLimit" > "$cardType/$issuingBank/$fileName"
done < <(tail -n +2 "$file")
