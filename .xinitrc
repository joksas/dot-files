#!/bin/sh

# Xresources
xrdb ~/.Xresources &

# Language
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
fcitx &

# Monitors
~/.screenlayout/layout.sh

# Background
feh --bg-fill --randomize ~/Pictures/backgrounds/* &

# Layouts
setxkbmap -layout gb,lt -option grp:alt_shift_toggle

# Window size
export WINIT_HIDPI_FACTOR=1.0

# Transparency
picom --fade-in-step=0.04 --fade-out-step=0.04 &

# Status bar
dwmblocks &

# Launch dwm
exec dwm
