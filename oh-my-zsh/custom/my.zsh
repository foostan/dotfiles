#==============================
# Language
#==============================
export LANG=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export PAGER=less

#==============================
# Path
#==============================
export PATH=${PATH}:${HOME}/bin:/usr/local/bin:/usr/local/sbin:/usr/local/share/hyperestraier/filter

#==============================
# Zsh options
#==============================
setopt auto_cd # auto change directory, cd foo -> foo
setopt auto_pushd # auto directory pushd, you can get dirs list by cd -[tab]
setopt correct # command correct edition before each completion attempt
setopt list_packed # compacked complete list display
setopt noautoremoveslash # no remove postfix slash of command line
setopt nolistbeep # no beep sound when complete list displayed

#==============================
# Command history
#==============================
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt hist_ignore_dups # ignore duplication command history list
setopt share_history # share command history data
autoload history-search-end
## install peco before initialize zsh
## go get github.com/peco/peco/cmd/peco
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

#==============================
# Alias
#==============================
setopt complete_aliases # aliased ls needs if file/dir completions work
alias where="command -v"
alias j="jobs -l"
case "${OSTYPE}" in
freebsd*|darwin*)
 alias ls="ls -G -w -F"
 alias la="ls -a"
 ;;
linux*)
 alias ls="ls --color"
 alias la="ls -a"
 ;;
esac
alias ll="ls -al"
alias du="du -h"
alias df="df -h"
alias su="su -l"
alias screen="export SCREEN=YES ; screen -U -T ${TERM}"
alias vim="nocorrect vim"
alias vagrant='nocorrect vagrant'
alias va='vagrant'
alias be='bundle exec'

#==============================
# Editor
#==============================
export EDITOR=vim

#==============================
# Terminal configuration
#==============================
unset LSCOLORS
case "${TERM}" in
xterm)
 export TERM=xterm
 ;;
xterm-color)
 export TERM=xterm-color
 ;;
xterm-256color)
 export TERM=xterm-256color
 ;;
kterm)
 export TERM=kterm-color
 # set BackSpace control character
 stty erase
 ;;
cons25)
 unset LANG
 export LSCOLORS=ExFxCxdxBxegedabagacad
 export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
 zstyle ':completion:*' list-colors \
   'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
 ;;
esac
## set terminal title including current directory
case "${TERM}" in
kterm*|xterm*) 
 precmd() {
   echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
 }
 export LSCOLORS=exfxcxdxbxegedabagacad
 export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
 zstyle ':completion:*' list-colors \
   'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
  ;;
esac
## load user .zshrc configuration file
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine

#==============================
# Peco
#==============================
alias -g P='| peco'

#==============================
# Git
#==============================
alias -g B='`git branch -a | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'
alias -g R='`git remote | peco --prompt "GIT REMOTE>" | head -n 1`'

#==============================
# Ruby
#==============================
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/shims:$PATH"
export PATH="$HOME/.gem/ruby/2.0.0/bin:$PATH"

#==============================
# Node
#==============================
[[ -s /Users/foostan/.nvm/nvm.sh ]] && . /Users/foostan/.nvm/nvm.sh
nvm use v0.10.25 1>/dev/null
npm_dir=${NVM_PATH}_modules
export NODE_PATH=$npm_dir

#==============================
# Go
#==============================
export GOPATH="$HOME/sandbox"
export GOROOT="/usr/local/go"
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

#==============================
# Docker
#==============================
export DOCKER_HOST=tcp://$(boot2docker ip 2>/dev/null):2375
