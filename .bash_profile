#
# ~/.bash_profile
#
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Environment varibles
[[ -f "$HOME/.config/sh/env" ]] && . "$HOME/.config/sh/env"

# red coloured cursor in select ttys
[[ $(tty) != '/dev/tty1' && $(tty) != '/dev/tty[3-4]' ]] && echo -e '\e[?16;0;200c'

# Start programs independent of graphical session
sudo updatedb &

# Start X session
if [[ "$(tty)" == '/dev/tty1' ]]; then
    pgrep -x dwm || export MYTERM='st' && exec startx
elif [[ "$(tty)" == '/dev/tty3' ]]; then
    pgrep xmonad || export MYTERM='alacritty' && exec startx
elif [[ "$(tty)" == '/dev/tty4' ]]; then
    pgrep -x qtile || export MYTERM='alacritty' && exec startx
fi
