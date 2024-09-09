# Environment varibles
[ -f "$HOME/.config/shell/env" ] && . "$HOME/.config/shell/env"

[ -f ~/.bashrc ] && . ~/.bashrc

# Start ssh master session for using jrnl via ctrlc pubnix.
{ while true ; do
    if [ ! -S "$HOME/.ssh/controlmasters/flaafy@ctrl-c.club:22" ]; then
        nice -n 19 nm-online -q -t 60 && \
            nice -n 19 ssh -NT -o 'ServerAliveInterval 15' -o 'ServerAliveCountMax 10' ctrlc
        notify-send 'Restarting Ctrl-C Connection ...'
    fi
    sleep 10
done } &

# All WMs are mapped to particular TTYs.
export TTY=$(tty)

# Load programs not requiring GUI session but to be started only for GUI sessions.
gui_ttys=( '/dev/tty1' '/dev/tty2' '/dev/tty3' )

# This "element in array" check works only for single-word elements.
if [[ "${gui_ttys[*]}" =~ "$TTY" ]]; then
    nice -n 19 sudo updatedb & &> /dev/null
fi

# # Load GUI session mapped to current TTY (if any).
# if [ "$TTY" == '/dev/tty1' -o "$TTY" == '/dev/tty3' ]; then
#     exec startx
# elif [ "$TTY" = '/dev/tty2' ]; then
#     exec Hyprland
# fi

# Red coloured cursor in non-graphical ttys
echo -e '\e[?16;0;200c'
# Set a good looking TTY font.
setfont ter-u20b
