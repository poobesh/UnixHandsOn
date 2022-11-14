#!/bin/bash

datesComparision(){
	if [ $1 -gt $(date +%Y) ]
    then
        account_check=active
    elif [[ $1 -eq $(date +%Y) && $2 -gt $(date +%m) ]]
    then
        account_check=active
    else
        account_check=expired
    fi
}

numToUsd(){
    usd=`echo $1 | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta' | sed 's/^/$/' | sed 's/$/ USD/'`
}

directory(){
    dir=`echo $1 | sed 's/ /\\ /g'`
}

while IFS="," read -r cardType cardFull issueBank cardNum holdName cvv issueDate expiryDate billingDate cardPIN creditLim

do
	expiryYear="${expiryDate:3:6}"
	expiryMonth=$[$((10#${expiryDate:0:2}))]
    datesComparision $expiryYear $expiryMonth
    numToUsd $creditLim
    directory $cardFull
    parentDirectory=$(echo $cardFull |  sed 's/ /_/g')
    childDirectory=$(echo $issueBank | sed 's/ /_/g;t')
    mkdir -p $parentDirectory/$childDirectory
    cd  $parentDirectory/$childDirectory

    if [ $account_check = 'active' ]
    then
			echo "Card Type Code : $cardType
Card Type Full Name : $cardFull
Issuing Bank : $issueBank
Card Number : $cardNum
Card Holder's Name : $holdName
CVV/CVV2 : $cvv
Issue Date : $issueDate
Expiry Date : $expiryDate
Billing Date : $billingDate
Card PIN : $cardPIN
Credit Limit : $usd" > $cardNum.active
    else
        echo "Card Type Code : $cardType
Card Type Full Name : $cardFull
Issuing Bank : $issueBank
Card Number : $cardNum
Card Holder's Name : $holdName
CVV/CVV2 : $cvv
Issue Date : $issueDate
Expiry Date : $expiryDate
Billing Date : $billingDate
Card PIN : $cardPIN
Credit Limit : $usd" > $cardNum.expired
    fi      
cd ..
cd ..
done < <(tail -n +2 100\ CC\ Records.csv)