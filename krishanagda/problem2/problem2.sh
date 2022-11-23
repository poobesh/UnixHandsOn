#!/bin/bash

#Current Date
currentDate=$(date +"%d/%m/%Y")
echo -e "$currentDate\n"

#Current Time
currentTime=$(date +"%r")
echo -e "$currentTime\n"

#Current User
echo -e "$USERNAME\n"

#Current Working Directory
echo -e "$PWD\n"
