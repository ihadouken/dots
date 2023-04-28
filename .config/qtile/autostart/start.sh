#!/bin/bash
kill -s USR1 $(pidof sxhkd)
# pgrep -x conky || (conky -c $HOME/.config/conky/qtile/doom-one-01.conkyrc &) && disown
