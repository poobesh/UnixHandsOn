echo "enter a number to reverse:"
read n
n1=0
while [ $n -gt 0 ]
do
n1=$(expr $n1 \* 10)
k1=$(expr $n % 10)
n1=$(expr $n1 + $k1)
n=$(expr $n / 10)
done
echo number is $n1
