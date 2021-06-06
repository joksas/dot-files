#!/bin/sh

# Xresources
xrdb ~/.Xresources &

# Dual monitor
if [ `xrandr | grep -c ' connected '` -eq 2 ]; then
  xrandr --output DP-1 --primary --mode 3840x2160 --output LVDS-1 --off --rotate normal
fi

# Language
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
fcitx &

# dwm status bar
dwmblocks 2>&1 >/dev/null &

# Launch dwm
exec dwm
