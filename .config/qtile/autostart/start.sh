#!/bin/bash
killall sxhkd && (sxhkd &) && disown
# pgrep -x conky || (conky -c $HOME/.config/conky/qtile/doom-one-01.conkyrc &) && disown
exit
