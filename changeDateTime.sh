#!/bin/bash

# Ask the user to enter a date
echo "Enter a date (YYYY-MM-DD HH:MM:SS): "
read user_date

#Convert date to seconds
date_in_seconds=$(date -j -f "%Y-%m-%d %H:%M:%S" "$user_date" "+%s")

#Check if date conversion worked
if [[ $date_in_seconds =~ ^[0-9]+$ ]]; then
    echo "Setting new date/time"
	echo "$date_in_seconds" >> time.txt
else
    echo "Date/Time conversion failed!"
fi
