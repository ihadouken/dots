#
# ~/.bash_profile
#
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Environment varibles
[[ -f "$HOME/.config/sh/env" ]] && . "$HOME/.config/sh/env"

# red coloured cursor in select ttys
[[ $(tty) != '/dev/tty1' && $(tty) != '/dev/tty[3-4]' ]] && echo -e '\e[?16;0;200c'

# Start programs independent of graphical session
nice -n 19 sudo updatedb &

# Start X session
if [[ "$(tty)" == '/dev/tty1' ]]; then
    if ! pgrep -x qtile; then
        export XDG_SESSION_DESKTOP="qtile"
        export MYTERM='st'
        exec startx
    fi

elif [[ "$(tty)" == '/dev/tty3' ]]; then
    export XDG_SESSION_DESKTOP="hypr"
    export MYTERM='foot'
    exec Hyprland

elif [[ "$(tty)" == '/dev/tty4' ]]; then
    if ! pgrep xmonad; then
        export XDG_SESSION_DESKTOP="xmonad"
        export MYTERM='alacritty'
        exec startx
    fi
fi
