#   _       _
#  | |__   | | _____ _ __
#  | '_ \  | |/ / _ \ '_ \
#  | | | | |   <  __/ | | |
#  |_| |_| |_|\_\___|_| |_| 
#
# My bash config. Not much to see here; just some pretty standard stuff.

### EXPORT
# export TERM="xterm-256color"                      # getting proper colors
export HISTFILE="$HOME/.bash_history"
export HISTSIZE=1000
export HISTFILESIZE=10000
export HISTCONTROL=ignoredups:erasedups           # no duplicate entries

### SET VI MODE ###
# Comment this line out to enable default emacs-like bindings
set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'
#bind -m vi-command 'Control-e: edit-and-execute-command'
#bind -m vi-insert 'Control-e: edit-and-execute-command'

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

### PROMPT
# This is commented out if using starship prompt
# PS1='[\u@\h \W]\$ '
#PS1='\n\[\e[1;32m\]  \j\[\e[0m\] \[\e[1;34m\][\[\e[0m\e[1;34m\]hk@ \[\e[0m\]\[\e[1;31m\]tmux\[\e[0m\] \[\e[1;35m\]\w\[\e[0m\]\[\e[1;34m]\]\[\e[0m\]\$ '
#PS2='\033[0;2m... \033[0m'

### PATH
#if [ -d "$HOME/.local/bin" ] ;
#  then PATH="$HOME/.local/bin:$PATH"
#fi

#if [ -d "$HOME/Applications" ] ;
#  then PATH="$HOME/Applications:$PATH"
#fi

### CHANGE TITLE OF TERMINALS
case ${TERM} in
  xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|alacritty|st|konsole*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
        ;;
  screen*)
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
    ;;
esac

### SHOPT
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s histappend # do not overwrite history
shopt -s expand_aliases # expand aliases
shopt -s checkwinsize # checks term size when bash regains control

#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

### ALIASES ###
[[ -f $XDG_CONFIG_HOME/sh/aliasrc ]] && . $XDG_CONFIG_HOME/sh/aliasrc

# last command root privileges
alias pls='doas $(history -p !!) && printf "\n\033[1;35m%s\n\033[0m" "You are welcome."'


# vim and emacs
alias vim="nvim"
alias emc="/usr/bin/emacs -nw"
alias em="devour emacsclient -c -a 'emacs'"
alias doomsync="~/.emacs.d/bin/doom sync"
alias doomdoctor="~/.emacs.d/bin/doom doctor"
alias doomupgrade="~/.emacs.d/bin/doom upgrade"
alias doompurge="~/.emacs.d/bin/doom purge"

# Changing "ls" to "exa"
alias ls='exa -alh --color=always --no-user --no-time --group-directories-first'  # long format
alias lx='exa -alh --color=always --group-directories-first' # my preferred listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --no-user --no-time --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing
alias l.='exa -a | grep -E "^\." | tr "\n" " " | column -t'



# paru and yay
alias yaysua='yay -Sua --noconfirm'              # update only AUR pkgs (yay)
alias yaysyu='yay -Syu --noconfirm'              # update standard pkgs and AUR pkgs (yay)
alias parsua='paru -Sua --noconfirm'             # update only AUR pkgs (paru)
alias parsyu='paru -Syu --noconfirm'             # update standard pkgs and AUR pkgs (paru)

# get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -iv"
alias mv='mv -iv'
alias rm='rm -i'
alias ln='ln -iv'

# adding flags
#alias vifm='./.config/vifm/scripts/vifmrun'
#alias ncmpcpp='ncmpcpp ncmpcpp_directory=$HOME/.config/ncmpcpp/'
#alias mocp='mocp -M "$XDG_CONFIG_HOME"/moc -O MOCDir="$XDG_CONFIG_HOME"/moc'

# Merge Xresources
alias merge='xrdb -merge ~/.Xresources'

# git
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias stat='git status'  # 'status' is protected name so using 'stat' instead
alias tag='git tag'
alias newtag='git tag -a'

# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# gpg encryption
# verify signature for isos
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
# receive the key of a developer
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

# youtube-dl
alias yta-aac="youtube-dl --extract-audio --audio-format aac "
alias yta-best="youtube-dl --extract-audio --audio-format best "
alias yta-flac="youtube-dl --extract-audio --audio-format flac "
alias yta-m4a="youtube-dl --extract-audio --audio-format m4a "
alias yta-mp3="youtube-dl --extract-audio --audio-format mp3 "
alias yta-opus="youtube-dl --extract-audio --audio-format opus "
alias yta-vorbis="youtube-dl --extract-audio --audio-format vorbis "
alias yta-wav="youtube-dl --extract-audio --audio-format wav "
alias ytv-best="youtube-dl -f bestvideo+bestaudio "

# switch between shells
# I do not recommend switching default SHELL from bash.
#alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
#alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"
#alias tofish="sudo chsh $USER -s /bin/fish && echo 'Now log out.'"

# bare git repo alias for dotfiles
# alias config="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"

# Unlock LBRY tips
# alias tips='lbrynet txo spend --type=support --is_not_my_input --blocking'

### DTOS ###

# Copy/paste all content of /etc/dtos over to home folder. A backup of config is created. (Be careful running this!)
alias dtosupdate='mkdir ~/.update-backup-$(date +%Y.%m.%d-%H.%M.%S) && cp -Rf ~/.config ~/.xmonad ~/.local/bin ~/.bashrc ~/.update-backup-$(date +%Y.%m.%d-%H.%M.%S) && cp -rf /etc/dtos/* ~'

# Backup contents of /etc/dtos to a backup folder in $HOME.
alias dtosbackup='cp -Rf /etc/dtos ~/dtos-backup-$(date +%Y.%m.%d-%H.%M.%S)'


### RANDOM COLOR SCRIPT ###
# Get this script from my GitLab: gitlab.com/dwt1/shell-color-scripts
# Or install it from the Arch User Repository: shell-color-scripts
# colorscript random
# pokemon-colorscripts random

## Select one colorscript out of two colorscript packs using shuf

rand_num=$(shuf -i 1-2 -n 1)
case $rand_num in
    1)
        colorscript random ;;
    2)
        pokemon-colorscripts random ;;
#   3)
#       wal --preview | sed '/Current/d'
#       fortune | lolcat ;;
#   3)
#        neofetch;;
esac
unset rand_num

### PYWAL ###
#[[ -f ~/.cache/wal/sequences ]] && cat /home/hadouken/.cache/wal/sequences

### BASH INSULTER ###
if [ -f /etc/bash.command-not-found ]; then
    . /etc/bash.command-not-found
fi

### SETTING THE STARSHIP PROMPT ###
eval "$(starship init bash)"

### POWERLINE SHELL ###
#function _update_ps1() {
#    echo ""
##    echo ""
#    PS1=$(powerline-shell $?)
#}

#if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
#    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
#fi

if [ "$(cat ~/.bash_history | wc -l)" -gt 9000 ]; then
    printf "\033[1;31m *** History exceeds pre-cautionary limit."
fi

complete -cf doas
PS2='\033[0;2m... \033[0m'
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
