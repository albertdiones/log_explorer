#!/bin/sh

# Prompt the user for input
echo "Input the date you want to search (e.g., YYYY-MM-DD):"
read INPUT_DATE

echo "Input the time you want to search (optional, e.g., HH:MM in 24-hour format):"
read INPUT_TIME

# Convert the input date to the desired format (MM/DD/YYYY)
DATE=$(date -d "$INPUT_DATE" '+%m/%-d/%Y')

# Convert the input time to 12-hour format with AM/PM
if [ -n "$INPUT_TIME" ]; then
    TIME=$(date -d "$INPUT_TIME" '+%-I:%M:%S %p')
fi

# Format the date and time to match the log format
SEARCH="^\\[$DATE"
if [ -n "$TIME" ]; then
    SEARCH="$SEARCH, $TIME"
fi

# Check if a file was provided
if [ -z "$1" ]; then
    echo "Usage: $0 <logfile>"
    exit 1
fi


echo $SEARCH

# Perform the search
grep -E "$SEARCH" "$1"
