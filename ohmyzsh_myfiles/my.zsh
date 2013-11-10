## Language setting
export LANG=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export PAGER=less
export EDITOR=vim
## PATH
export PATH=${PATH}:${HOME}/bin:/usr/local/bin:/usr/local/sbin:/usr/local/share/hyperestraier/filter
## auto change directory
setopt auto_cd
## auto directory pushd that you can get dirs list by cd -[tab]
setopt auto_pushd
## command correct edition before each completion attempt
setopt correct
## compacked complete list display
setopt list_packed
## no remove postfix slash of command line
setopt noautoremoveslash
## no remove postfix slash of command line
setopt noautoremoveslash
## no beep sound when complete list displayed
setopt nolistbeep
## Keybind configuration
bindkey -e
## historical backward/forward search with linehead string binded to ^P/^N
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end
## Command history configuration
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt hist_ignore_dups # ignore duplication command history list
setopt share_history # share command history data
## Completion configuration
autoload -U compinit
compinit
## Alias configuration
setopt complete_aliases # aliased ls needs if file/dir completions work
alias where="command -v"
alias j="jobs -l"
case "${OSTYPE}" in
freebsd*|darwin*)
 alias ls="ls -a -G -w -F"
 ;;
linux*)
 alias ls="ls -a --color"
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
## terminal configuration
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
if [ "$SCREEN" = "YES" ]; then
#       chpwd () { echo -n "\" }
#       preexec() {
#               # see [zsh-workers:13180]
#               # http://www.zsh.org/mla/workers/2000/msg03993.html
#               emulate -L zsh
#               local -a cmd; cmd=(${(z)2})
#               case $cmd[1] in
#                       fg)
#                               if (( $#cmd == 1 )); then
#                                       cmd=(builtin jobs -l %+)
#                               else
#                                       cmd=(builtin jobs -l $cmd[2])
#                               fi
#                               ;;
#                       %*) 
#                               cmd=(builtin jobs -l $cmd[1])
#                               ;;
#                       cd)
#                               if (( $#cmd == 2)); then
#                                       cmd[1]=$cmd[2]
#                               fi
#                               ;&
#                       *)
#                               echo -n "\"
#                               return
#                               ;;
#               esac
#               local -A jt; jt=(${(kv)jobtexts})
#               $cmd >>(read num rest
#                       cmd=(${(z)${(e):-\$jt$num}})
#                       echo -n "\") 2>/dev/null
#       }
#       chpwd
fi
## load user .zshrc configuration file
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine

# autojump
[[ -s ~/.autojump/etc/profile.d/autojump.zsh ]] && . ~/.autojump/etc/profile.d/autojump.zsh

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
