#
# ~/.bash_profile
#
[[ -f ~/.bashrc ]] && . ~/.bashrc

### XDG BASE DIR ###
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export GTK3_RC_FILES="$XDG_CONFIG_HOME"/gtk-3.0/gtkrc
export MYSQL_HISTFILE="$XDG_DATA_HOME"/mysql_history
export ANDROID_HOME="$XDG_DATA_HOME"/android
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GOPATH="$XDG_DATA_HOME"/go
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
export SQLITE_HISTORY="$XDG_CACHE_HOME"/sqlite_history
export STACK_ROOT="$XDG_DATA_HOME"/stack
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc

# Xorg
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority

# python
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"
export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/python"
export PYTHONUSERBASE="$XDG_DATA_HOME/python"
export PATH="$PATH:$HOME/.local/share/python/bin"
export MYPY_CACHE_DIR="$XDG_CACHE_HOME"/mypy

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"


### hadouken ###
#export MYTERM="xterm"
export MYSRC="$HOME/.local/src"
export MYEMACS="emacsclient -c -a 'emacs'"
[[ -d "$HOME/.local/bin" ]] &&  export PATH="$PATH:$HOME/.local/bin"
[[ -d "$HOME/.local/bin/status-bar" ]] && export PATH="$PATH:$HOME/.local/bin/status-bar" 
export TMPDIR='/tmp'
export STARDICT_DATA_DIR="$XDG_DATA_HOME/stardict"

# for qt5ct
export QT_QPA_PLATFORMTHEME='qt5ct'


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
