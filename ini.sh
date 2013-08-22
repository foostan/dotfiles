#!/bin/sh
DOTFILE_PATH=$(cd $(dirname $0) && pwd)

# update submodules
git submodule foreach 'git checkout master; git pull'

# set up oh-my-zsh files
ln -sf $DOTFILE_PATH/ohmyzsh_myfiles/my.zsh .oh-my-zsh/custom/my.zsh
ln -sf $DOTFILE_PATH/ohmyzsh_myfiles/my.zsh-theme .oh-my-zsh/themes/my.zsh-theme

# set up dotfiles
for dotfile in .?*
do
    if [ $dotfile != '..' ] && [ $dotfile != '.git' ]
    then
        ln -sf "$DOTFILE_PATH/$dotfile" $HOME
    fi
done
