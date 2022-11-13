file=records.csv
OLDIFS=$IFS
tdyDate=$(date +"%Y%M") 
while IFS=',' read cardTypeCode cardTypeFullName issuingBank cardNumber cardHolderName cvv issueDate expiryDate billingDate cardPin creditLimit
do
    year=${expiryDate:3:4}
    month=${expiryDate:0:2}
    exp=$year$month
    #echo $exp
    if [ $exp -gt $tdyDate ]
    then
        aOre="active"
    else
        aOre="expired"
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
Credit Limit : $var" > $cardNumber.$aOre
    cd ..
    cd ..
done < (tail -n +2 $file)
IFS=$OLDIFS