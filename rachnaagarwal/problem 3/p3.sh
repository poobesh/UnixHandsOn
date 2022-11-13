echo "Enter a number"
read n
rev=0
sd=0

while [ $n -gt 0 ]
do
sd=`expr $n % 10`
rev=`expr $rev \* 10 + $sd`
n=`expr $n / 10`
done
echo "Reverse number is $rev"
