#!/bin/sh

# allow root user to run x11 programs
xhost local:root

# map the Zap combination
setxkbmap -option terminate:ctrl_alt_bksp

# set a fast key repeat
xset r rate 250 55

# set default cursor
xsetroot -cursor_name left_ptr

# disable mouse
#xinput set-prop 8 "Device Enabled" 0
#unclutter -idle 3 -root &
unclutter --fork --timeout 5

#
#intel_backlight 70%

# use xrandr to disable monitors that should not be used. For example,
# use only the DVI monitor of a VGA/DVI pair:
# /usr/local/bin/xrandr --output VGA-0 --off
~/bin/smonitor

# disable touchpad
~/bin/stouchpad

#
~/bin/bmon &

#
#~/bin/skak-lsp &

# run xterm with no border, white text on a black background, maximized,
# with large fonts.
# xterm -borderwidth 0 -fg white -bg black -maximized -fn 10x20 &
# urxvt

# Wallpaper
feh --no-fehbg --bg-center ~/images/free_wall_g_2.png &
#~/bin/swall &

# Compositor --vsync opengl-swc --backend xr_glx_hybrid
#compton --config /dev/null --vsync opengl-swc --backend xr_glx_hybrid --paint-on-overlay --glx-no-stencil --glx-no-rebind-pixmap --glx-swap-method buffer-age --xrender-sync-fence -b
compton --config /dev/null --vsync none --backend xrender -b

#exec spectrwm
exec bspwm
