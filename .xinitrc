#!/bin/sh

# Disable DRI3 on Mesa
# export LIBGL_DRI3_DISABLE=1

# Set PATH
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:$HOME/.local/bin

# Set default terminal
export TERMINAL=xterm

# To determine X11
export FSIZE=10
export FNAME="JetBrains Mono"

# For fast run commands
export SXHKD_SHELL="/bin/sh"

# For mpc
export MPD_HOST=/var/mpd/socket

# allow root user to run x11 programs
xhost local:root

# map the Zap combination
setxkbmap -option terminate:ctrl_alt_bksp

# set a fast key repeat
xset r rate 250 55

# set default cursor
xsetroot -cursor_name left_ptr

# Disable DPMS and prevent screen from blanking
#xset s off -dpms

export QT_QPA_PLATFORMTHEME=qt5ct

# Load xresouces
xrdb -DFNAME="$FNAME" -DFSIZE="$FSIZE" ~/.Xdefaults

# Set screen backlight
# intel_backlight 51

# Restart sndiod to fix clients connection
doas service sndiod restart

# webcam power save
CAM=`doas usbconfig list | grep "Camera" | cut -f 1 -d ":"`
if [ -n $CAM ]; then
	doas usbconfig $CAM suspend
fi

# disable mouse
#xinput set-prop 8 "Device Enabled" 0
#unclutter -idle 3 -root &
unclutter --fork --timeout 5

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
feh --no-fehbg --bg-center $WALLPAPER_STATIC_PATH &
# mpv --wid=0 --loop $WALLPAPER_ANIMATED_PATH &
# ~/bin/swall &

# disable touchpad
stouchpad &

#
bmon &

#

if [ ! -d /tmp/cache ]; then
	mkdir -p /tmp/cache
fi

# if [ ! -d /tmp/cache/chromium ]; then
# 	mkdir -p /tmp/cache/chromium
# fi

if [ ! -d $HOME/.cache/chromium ]; then
	ln -s /dev/null $HOME/.cache/chromium
fi

# run xterm with no border, white text on a black background, maximized,
# with large fonts.
# xterm -borderwidth 0 -fg white -bg black -maximized -fn 10x20 &
# urxvt

# Compositor
picom --config=/dev/null --experimental-backends --backend=xrender --use-damage --vsync=opengl -b

sxhkd &
exec bspwm
