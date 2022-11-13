#!/bin/bash
now="$(date +'%d/%m/%Y')"
time="$(date +'%r')"
user="$(id -u -n)"
echo "Current Date is $now"
echo "Current Time is $time"
echo "Username is $user"
echo "Current Working Directory is `pwd`"
