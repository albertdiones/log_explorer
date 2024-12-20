#!/bin/bash


./search-by-minute.sh $1 $2 $3


UNIX_TIMESTAMP=$(date -d "$2 $3" '+%s')

while true; do
  # Read input
  read -r -n1 input  # Read one character

  # Check if it's an escape sequence (starts with ESC)
  if [ "$input" = $'\e' ]; then
    read -r -n2 -t 0.1 input  # Read the next two characters
    case "$input" in
      "[D")
        clear
        UNIX_TIMESTAMP=$(($UNIX_TIMESTAMP-60))
        NEW_TIME=$(date -d "@$UNIX_TIMESTAMP" '+%I:%M')
        ./search-by-minute.sh $1 $2 $NEW_TIME
        ;;
      "[C")
        clear
        UNIX_TIMESTAMP=$(($UNIX_TIMESTAMP+60))
        #echo $(($UNIX_TIMESTAMP-60))        

        NEW_TIME=$(date -d "@$UNIX_TIMESTAMP" '+%I:%M')
        ./search-by-minute.sh $1 $2 $NEW_TIME
        ;;
    esac
  elif [ "$input" = "q" ]; then
    echo "Goodbye!"
    break
  fi
done