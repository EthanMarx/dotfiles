#!/bin/bash
MAX_LEN=20
SCROLL_POS=0

while true; do
    TEXT=$(playerctl metadata --player=spotify --format '󰓇  {{artist}} - {{title}}' 2>/dev/null)
    if [[ -z "$TEXT" ]]; then
        echo ""
        SCROLL_POS=0
        sleep 5
        continue
    fi
    LEN=${#TEXT}
    if [[ $LEN -le $MAX_LEN ]]; then
        echo "$TEXT"
        SCROLL_POS=0
        sleep 5
    else
        echo "${TEXT:$SCROLL_POS:$MAX_LEN}"
        SCROLL_POS=$(( (SCROLL_POS + 1) % (LEN - MAX_LEN + 1) ))
        sleep 0.5
    fi
done
