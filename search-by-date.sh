#!/bin/sh

# Check if a second parameter (date) is supplied
if [ -z "$2" ]; then
    # Prompt the user for input
    echo "Input the date you want to search (e.g., YYYY-MM-DD):"
    read INPUT_DATE
else
    INPUT_DATE="$2"
fi

if [ -z "$3" ]; then
    echo "Input the time you want to search (optional, e.g., HH:MM:SS in 24-hour format):"
    read INPUT_TIME
else
    INPUT_TIME="$3"
fi



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

# Perform the search
grep -E "$SEARCH" "$1"