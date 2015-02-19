function do_enter() {
    if [ -n "$BUFFER" ]; then
        zle accept-line
        return 0
    fi
    echo

    # ls
    echo -e "\e[0;30m[ ls ]\e[0m"
    ls

    # git status
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
        echo
        echo -e "\e[0;30m[ git status ]\e[0m"
        git status -sb
    fi

    zle reset-prompt
    return 0
}
zle -N do_enter
bindkey '^m' do_enter
