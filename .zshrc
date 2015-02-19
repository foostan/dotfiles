# oh-my-zsh configurations
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="my"
COMPLETION_WAITING_DOTS="true"
plugins=(
    #==============================
    # custom
    #==============================
    enter
    peco-history
    peco-ssh
    peco-pushd

    #==============================
    # official
    #==============================
    # language
    golang

    # git
    git
    gitfast

    # virtualization
    vagrant

    # others
    osx
)
source $ZSH/oh-my-zsh.sh
