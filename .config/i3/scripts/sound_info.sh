#!/bin/sh

case $BLOCK_BUTTON in
	1) setsid xterm -e alsamixer & ;;
	2) amixer sset Master toggle ;;
	4) amixer -q -D pulse sset Master 5%+ ;; 
	5) amixer -q -D pulse sset Master 5%- ;; 
	3) pgrep -x dunst >/dev/null && notify-send -t 4000 "Volume module" "\- Shows volume ,  if muted.
- Middle click to mute.
- Scroll to change."
esac

VOLUME_MUTE=""
VOLUME_LOW=""
VOLUME_HIGH=""
SOUND_LEVEL=$(amixer -M get Master | awk -F"[][]" '/%/ { print $2 }' | awk -F"%" 'BEGIN{tot=0; i=0} {i++; tot+=$1} END{printf("%s\n", tot/i) }')
MUTED=$(amixer get Master | awk ' /%/{print ($NF=="[off]" ? 1 : 0); exit;}')

ICON=$VOLUME_MUTE
if [ "$MUTED" = "1" ]
then
    ICON="$VOLUME_MUTE"
    SOUND_LEVEL="0"
else
    if [ "$SOUND_LEVEL" -eq 0 ]
    then
        ICON="$VOLUME_MUTE"
    elif [ "$SOUND_LEVEL" -lt 50 ]
    then
        ICON="$VOLUME_LOW"
    else
        ICON="$VOLUME_HIGH"
    fi
fi

echo "$ICON" "$SOUND_LEVEL" | awk '{ printf(" %s %3s%% \n", $1, $2) }'
