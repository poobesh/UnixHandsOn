echo "enter a number to reverse"
read n
num=0
while [ $n -gt 0 ]
do
num=$(expr $num \*  10)
rem=$(expr $n % 10)
num=$(expr $num + $rem)
n=$(expr $n / 10)
done
echo "The reverse  is $num"
