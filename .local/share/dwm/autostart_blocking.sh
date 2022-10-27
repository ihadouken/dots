#!/bin/bash
wal -Rq
sudo recompile-dwm.sh > /dev/null || notify-send -i '/usr/share/icons/Papirus-Light/1x16/panel/state-error.svg' -u low "[Error]: Couldn't compile dwm"
xdotool key super+F5
