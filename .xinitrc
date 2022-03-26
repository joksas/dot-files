#!/bin/sh

# Xresources
xrdb ~/.Xresources &

# Language
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
fcitx &

# dwm status bar
dwmblocks 2>&1 >/dev/null &

# Background
feh --bg-fill --randomize ~/Pictures/backgrounds/* &

# Window size
export WINIT_HIDPI_FACTOR=1.0

# Transparency
picom --fade-in-step=0.04 --fade-out-step=0.04 &

# Launch dwm
exec dwm
