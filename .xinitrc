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

# Launch dwm
exec dwm
