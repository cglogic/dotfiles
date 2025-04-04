#!/bin/sh

# Disable DRI3 on Mesa
# export LIBGL_DRI3_DISABLE=1

# Set PATH
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:$HOME/.local/bin

# Set default terminal
# export TERMINAL=xterm
export TERMINAL=zutty

# To determine X11
export FSIZE=20
export FNAME="JetBrains Mono"

# For fast run commands
export SXHKD_SHELL="/bin/sh"

# allow root user to run x11 programs
xhost local:root

# map the Zap combination
setxkbmap -option terminate:ctrl_alt_bksp

# set a fast key repeat
xset r rate 250 50

# set default cursor
xsetroot -cursor_name left_ptr

# Disable DPMS and prevent screen from blanking
#xset s off -dpms

# Load xresouces
xrdb -DFNAME="$FNAME" -DFSIZE="$FSIZE" ~/.Xdefaults

# webcam power save
# CAM=`doas usbconfig list | grep "Camera" | cut -f 1 -d ":"`
# if [ -n $CAM ]; then
# 	doas usbconfig -d $CAM suspend
# fi

# disable mouse
#xinput set-prop 8 "Device Enabled" 0
#unclutter -idle 3 -root &
unclutter --start-hidden --fork --timeout 5

# Run xnotify
# export XNOTIFY_FIFO="/tmp/xnotify-$DISPLAY.fifo"
# rm -f $XNOTIFY_FIFO
# mkfifo $XNOTIFY_FIFO
# xnotify -o -s 2 <$XNOTIFY_FIFO 3<>$XNOTIFY_FIFO &

# use xrandr to disable monitors that should not be used. For example,
# use only the DVI monitor of a VGA/DVI pair:
# /usr/local/bin/xrandr --output VGA-0 --off
smonitor

export WALLPAPER_STATIC_PATH=~/wallpapers/bg-orig.png
export WALLPAPER_ANIMATED_PATH=~/wallpapers/bg-orig.mp4

# Wallpaper
# feh --no-fehbg --bg-center ~/images/free_wall_g_2.png &
feh --no-fehbg --bg-fill $WALLPAPER_STATIC_PATH &
# mpv --wid=0 --loop $WALLPAPER_ANIMATED_PATH &
# ~/bin/swall &

# disable touchpad
stouchpad &

# Compositor --use-damage
picom --config=/dev/null --backend=xrender --vsync -b

sxhkd &
exec bspwm
