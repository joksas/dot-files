#!/bin/sh

all_lines=$(curl https://corona-stats.online/?source=2 | sed 's/\x1b\[[0-9;]*m//g' | awk -F "│" '{print $2 "|" $3 "["$4"] | " $5 "["$6"]" }' | sed "s/║//g ; s/╟//g ; s/═//g ; s/─//g ; s/╧//g ; s/┼//g ; s/╢//g ; s/╝//g ; s/╚//g ; s/╤//g ; s/╔//g ; s/╗//g " | sed -n '4~2p')
world_data=$(printf "$all_lines" | tail -6 | head -1)
top_ten_data=$(printf "$all_lines" | head -11 )
full_notification=$(printf " REGION | CASES | DEATHS \n${world_data}\n${top_ten_data}" | tr -s " " | sed "s/(.*)//g ; s/\[ /(+/g ; s/ \]/)/g ; s/^.//g ; s/ ▲//g ; s/(+\]//g" | column -t -s "|" 2>/dev/null)
header=$(printf "$full_notification" | head -1)
body=$(printf "$full_notification" | tail -11)
total_cases=$(printf "$body" | awk '{print $2}')

case $BLOCK_BUTTON in
  1) notify-send -t 5000 "$header" "$body" ;;
  3) firefox "https://www.worldometers.info/coronavirus" ;;
esac

echo "$total_cases"
