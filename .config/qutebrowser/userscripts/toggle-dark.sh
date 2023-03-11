#!/usr/bin/env bash
config="${XDG_CONFIG_HOME:-"$HOME"/.config}"/qutebrowser/config.py
darkmode="$(sed -n '/c\.colors\.webpage\.darkmode/p' "$config" | grep -o 'True\|False')"

if [[ "$darkmode" == 'True' ]]; then
    sed -i '/c\.colors\.webpage\.darkmode/s/True/False/' "$config"
else
    sed -i '/c\.colors\.webpage\.darkmode/s/False/True/' "$config"
fi

qutebrowser ':restart'

