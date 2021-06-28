#!/bin/sh

tp=$(sysctl dev.cpu | grep temperature | cut -f 2 -d " " | paste -s -d " " - | xargs echo "CPU")
bl=$(backlight -q | xargs echo 'Brightness')
vl=$(mixer -s pcm | cut -f 1- -d " " | xargs echo "Mixer")
bt=$(acpiconf -i 0 | grep "Remaining capacity" | paste -s -d " " - | xargs echo)
dt=$(date +'%Y-%m-%d %H:%M:%S')

echo "$tp | $bl | $vl | $bt | $dt"
