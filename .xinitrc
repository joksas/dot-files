#!/bin/sh

# Xresources
xrdb ~/.Xresources &

# Dual monitor
if [ `xrandr | grep -c ' connected '` -eq 2 ]; then
  xrandr --output LVDS-1 --mode 1366x768 --pos 1920x106 --rotate normal --output VGA-1 --output DP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal
fi

# Language
setxkbmap -layout gb,lt -option grp:alt_shift_toggle &

# dwm status bar
dwmblocks 2>&1 >/dev/null &

# Launch dwm
exec dwm
