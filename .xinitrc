#!/bin/sh

# Xresources
xrdb ~/.Xresources &

# Dual monitor
if [ `xrandr | grep -c ' connected '` -eq 2 ]; then
    xrandr --output DP-1 --auto --left-of LVDS-1 &
    xrandr --output LVDS-1 --pos 1920x128
fi

# Wallpaper
nitrogen --restore &

# Language
setxkbmap -layout gb,lt -option grp:alt_shift_toggle &

# dwm status bar
dwmblocks 2>&1 >/dev/null &

# Launch dwm
exec dwm
