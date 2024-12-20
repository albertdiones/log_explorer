#!/bin/sh


INPUT_DATE="$2"
INPUT_TIME="$3"

# Convert the input date to the desired format (MM/DD/YYYY)
DATE=$(date -d "$INPUT_DATE" '+%m/%-d/%Y')

# Convert the input time to 12-hour format with AM/PM
if [ -n "$INPUT_TIME" ]; then
    TIME=$(date -d "$DATE $INPUT_TIME" '+%-I:%M')
fi

TIME="$TIME:[0-9]{2}";

# AM/PM
TIME="$TIME $(date -d "$INPUT_TIME" '+%p')"

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

echo "search: $SEARCH"

# Perform the search
grep -E "$SEARCH" "$1"