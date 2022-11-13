#!/bin/sh
#export LC_ALL=en_IN.UTF-8
export LC_NUMERIC=en_US.UTF-8
INPUT="100 CC Records.csv"
OLDIFS=$IFS
IFS=','
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }

currentDate="$(date +'%m/%Y')"
now="${currentDate///}"

headDir="Credit_Card_Records"
if [ ! -d $headDir ]
then
        mkdir $headDir
fi

while read Code TName Bank Number HName CVV IDate EDate BDate Pin Limit
do
cd $headDir

        if [ $Code == "Card Type Code" ]
        then
                continue
        fi

        a=$Number
        a+="."
        exp="${EDate///}"
        nowMonth="${now:0:2}"
        expMonth="${exp:0:2}"
        nowYear="${now:2:4}"
        expYear="${exp:2:4}"
        if [ $nowYear -gt $expYear ]
        then
                a+="expired"
        elif [ $hh -gt $gg ]
        then
                a+="active"
        elif [ $ee -gt $ff ]
        then
                a+="expired"
        else
                a+="active"
        fi
        if [ ! -d $TName ]
        then
                mkdir $TName
        fi

        cd ./$TName
        if [ ! -d $Bank ]
        then
                mkdir $Bank
        fi
        touch ./$Bank/$a.txt
        cd ./$Bank
        us=$(printf "$%'.0f\n" $Limit)
        us+=" USD"
        printf "Card Type Code: $Code\nCard Type Full Name: $TName\nIssuing Bank: $Bank\nCard Number: $Number\nCard Holder's Name: $HName\nCVV/CVV2: $CVV\nIssue Dtae: $IDate\nExpiry Date: $EDate\nBilling Date: $BDate\nCard PIN: $Pin\nCredit Limit: $us\n" >> $a.txt
        cd ..
        cd ..

cd ..
done < $INPUT
IFS=$OLDIFS


