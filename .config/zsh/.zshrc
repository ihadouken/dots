### Oh My Zsh ###
export ZSH="$MY_SRC_DIR/oh-my-zsh"
ZSH_THEME="alanpeabody"
# ZSH_THEME="gnzh"
plugins=(taskwarrior git vi-mode)
source "$ZSH/oh-my-zsh.sh"

### Environmental variables ###
export HISTFILE="$XDG_CONFIG_HOME/zsh/.zsh_history"
export HISTSIZE=1000
export SAVEHIST=10000
export TMPDIR='/tmp'

### Shell variables ###

### PROMPT
# This is commented out if using starship prompt
# PS1='[\u@\h \W]\$ '
# PS1='\n\[\e[1;32m\]  \j\[\e[0m\] \[\e[1;34m\][\[\e[0m\e[1;34m\]hk@ \[\e[0m\]\[\e[1;31m\]tmux\[\e[0m\] \[\e[1;35m\]\w\[\e[0m\]\[\e[1;34m]\]\[\e[0m\]\$ '

# PS2='\033[0;2m... \033[0m'
PS2=$'%{\e[0;2m%}... %{\e[0m%}'
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
VI_MODE_SET_CURSOR=true

### Aliases ###
# aliases common with other shells
source "$XDG_CONFIG_HOME/sh/aliasrc"

# hot reload config
alias re="source $ZDOTDIR/.zshrc && /bin/clear"

# rerun last cmd as root
alias pls='doas $(fc -ln -1)'

### Completions ###
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### Insult on command-not-found error ###
if [ -f /etc/bash.command-not-found ]; then
    . /etc/bash.command-not-found
fi

### Helping my vocab ###
cowsay "$(shuf -n 1 "$HOME/Documents/words.txt")"
echo

### Show dotfiles repository status ###
#/usr/bin/git --git-dir=$MY_SRC_DIR/dotfiles --work-tree=$HOME status -s
