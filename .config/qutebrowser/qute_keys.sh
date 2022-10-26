#!/usr/bin/bash

sed -n '/START/,/END/p' ~/.config/qutebrowser/config.py \
| grep -v 'START\|END' \
| yad --text-info --back=#2f2d38 --fore=#b9b3d2 --geometry=1024x500
