echo "Card Type Code,Card Type Full Name,Issuing Bank,Card Number,Card Holder's Name,CVV/CVV2,Issue Date,Expiry Date,Billing Date,Card PIN,Credit Limit" >> consolidated.csv

for Folder in */
do
    cd "$Folder"
    for Folder2 in */ 
    do 
        cd "$Folder2"
        for file in * 
        do 
            while IFS=':' read c1 c2
            do
                var=$c2
                echo $var | awk '{printf $0","}' >> "../../consolidated.csv"
            done < $file
            echo "" >> "../../consolidated.csv"
        done
        cd ..
    done
    cd ..
done
