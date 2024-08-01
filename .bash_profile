# Environment varibles
[ -f "$HOME/.config/shell/env" ] && . "$HOME/.config/shell/env"

[ -f ~/.bashrc ] && . ~/.bashrc

# Start programs independent of session type here.
nice -n 19 sudo updatedb & &> /dev/null

# Start ssh master session for using jrnl via ctrlc pubnix.
{ while true ; do
    if [ ! -S "$HOME/.ssh/controlmasters/flaafy@ctrl-c.club:22" ]; then
        nice -n 19 nm-online -q -t 60 && nice -n 19 ssh -NT ctrlc
        notify-send 'Restarting Ctrl-C Connection ...'
    fi
    sleep 10
done } &

# All WMs are mapped to particular TTYs.
export TTY=$(tty)

if [ "$TTY" == '/dev/tty1' ]; then
    exec Hyprland
elif [ "$TTY" = '/dev/tty2' -o "$TTY" == '/dev/tty3']; then
    exec startx
else
    # Red coloured cursor in non-graphical ttys
    echo -e '\e[?16;0;200c'
    # Set a good looking TTY font.
    setfont ter-u20b
fi
