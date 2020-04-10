#!/bin/sh

case $BLOCK_BUTTON in
	1) notify-send -t 4000 "Process            %" "$(ps axch -o cmd:15,%cpu --sort=-%cpu | head)" ;;
	3) notify-send -t 2000 "CPU module " "\- Shows CPU temperature.
- Click to show the most intensive processes." ;;
esac

sensors | awk '/Core 0/ {print $3}'
