### Oh My Zsh ###
export ZSH="$MYSRC/omz"
# ZSH_THEME="alanpeabody"
ZSH_THEME="gnzh"
plugins=(taskwarrior git vi-mode)
source "$ZSH/oh-my-zsh.sh"

### Environmental variables ###
export HISTFILE="$XDG_CONFIG_HOME/zsh/.zsh_history"
export HISTSIZE=1000
export SAVEHIST=10000
export TMPDIR='/tmp'

### PROMPT
# This is commented out if using starship prompt
# PS1='[\u@\h \W]\$ '
# PS1='\n\[\e[1;32m\]  \j\[\e[0m\] \[\e[1;34m\][\[\e[0m\e[1;34m\]hk@ \[\e[0m\]\[\e[1;31m\]tmux\[\e[0m\] \[\e[1;35m\]\w\[\e[0m\]\[\e[1;34m]\]\[\e[0m\]\$ '

[[ -n "$SOCKS_REMOTE" ]] && PS1="(via %{$fg[cyan]%}$SOCKS_REMOTE%{$reset_color%}) $PS1"
PS2=$'%{\e[0;2m%}... %{\e[0m%}'

VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
VI_MODE_SET_CURSOR=true

### Aliases ###
# aliases common with other shells
[[ -f "$XDG_CONFIG_HOME/sh/aliasrc" ]] && source "$XDG_CONFIG_HOME/sh/aliasrc"

# hot reload config
alias re="source $ZDOTDIR/.zshrc && /bin/clear"

# rerun last cmd as root
alias pls='doas $(fc -ln -1)'

### Completions ###
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### fzf ###
[ -f  /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh

### Insult on command-not-found error ###
if [ -f /etc/bash.command-not-found ]; then
    . /etc/bash.command-not-found
fi

### Helping my vocab ###
cowsay "$(shuf -n 1 "$HOME/Documents/words.txt")"
echo

### Show dotfiles repository status ###
#/usr/bin/git --git-dir=$MYSRC/dotfiles --work-tree=$HOME status -s
