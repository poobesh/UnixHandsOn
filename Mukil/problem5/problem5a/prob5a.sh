fileName=100CCRecords.csv
OLDIFS=$IFS
curDate=$(date +"%Y%M") 

while IFS=',' read cardTypeCode cardTypeFullName issuingBank cardNumber cardHolderName cvv issueDate expiryDate billingDate cardPin creditLimit
do
    yr=${expiryDate:3:4}
    mon=${expiryDate:0:2}
    expDate=$yr$mon

    if [ $expDate -gt $curDate ]
    then
        expOrNot="active"
    else
        expOrNot="expired"
    fi

    mkdir -p "$cardTypeFullName"
    cd "$cardTypeFullName"
    mkdir -p "$issuingBank"
    cd "$issuingBank"
    var=`echo $creditLimit | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta' | sed 's/^/$/' | sed 's/$/ USD/'` 
    echo "Card Type Code : $cardTypeCode
    Card Type Full Name : $cardTypeFullName
    Issuing Bank : $issuingBank
    Card Number : $cardNumber
    Card Holder Name : $cardHolderName
    CVV/CVV2 : $cvv
    Issue Date : $issueDate
    Expiry Date : $expiryDate
    Billing Date : $billingDate
    Card PIN : $cardPin
    Credit Limit : $var" > $cardNumber.$expOrNot
    cd ..
    cd ..
done < <(tail -n +2 $fileName)
IFS=$OLDIFS