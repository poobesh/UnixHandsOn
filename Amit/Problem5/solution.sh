#! /bin/bash

file='100 CC Records.csv'

while IFS="," read -r cardType cardName issueBank cardNumber cardHolder cvv issueDate expiryDate billingDate cardPin creditLimit
do
    if [ ! -d "$cardName" ];
    then

        mkdir "$cardName"
    fi

    cd "$cardName"

    if [ ! -d "$issueBank" ];
        then
            mkdir "$issueBank"
    fi

    cd ..
    
    fileName=$cardNumber
    fileName+="."
    
    IFS="/"
    read -a monthYear <<< $expiryDate
    month=${monthYear[0]}
    year=${monthYear[1]}

    currMonth=`date +"%m"`
    currYear=`date +"%Y"` 

    if [  "$year" -gt "$currYear" ]
    then 
        fileName+=active.txt
        cd "$cardName"/"$issueBank"
        touch $fileName
        cd ..
        cd ..
    elif [ "$year" -le "$currYear" ]
    then
        if [ "$month" -gt "$currMonth" ]
        then
            fileName+=active
            cd "$cardName"/"$issueBank"
            touch $fileName
            cd ..
            cd ..
        else
            fileName+=expiry.txt
            cd "$cardName"/"$issueBank"
            touch $fileName
            cd ..
            cd ..
        fi
    fi

    dollar="$"
    limit=$dollar$creditLimit

    echo -e "Card Type Code: $cardType \nType Full Name: $cardName \nBank: $issueBank \nCard Number: $cardNumber \nCard Holder's Name: $cardHolder\nCVV/CVV2:$cvv\nIssue Date:$issueDate\nExpiry Date: $expiryDate\nBilling Date: $billingDate\nCard PIN: $cardPin\nCredit Limit: $limit" >> "$cardName/$issueBank/$fileName"

done < <(tail -n +2 "$file")

echo "Done"