# Environment varibles
[[ -f "$HOME/.config/sh/env" ]] && . "$HOME/.config/sh/env"

#
# ~/.bash_profile
#
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Start programs independent of session type here.
nice -n 19 sudo updatedb & &> /dev/null

# Start X session
if [[ "$(tty)" == '/dev/tty1' ]]; then
    if ! pgrep -x qtile; then
        export XDG_SESSION_DESKTOP='qtile'
        export MYTERM='st'
        exec startx
    fi

elif [[ "$(tty)" == '/dev/tty2' ]]; then
    export XDG_SESSION_DESKTOP='hypr'
    export MYTERM='footclient'
    exec Hyprland

elif [[ "$(tty)" == '/dev/tty3' ]]; then
    if ! pgrep xmonad; then
        export XDG_SESSION_DESKTOP="xmonad"
        export MYTERM='alacritty'
        exec startx
    fi
else
    # Red coloured cursor in non-graphical ttys
    echo -e '\e[?16;0;200c'
    setfont ter-u20b
fi
