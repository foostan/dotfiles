#!/bin/sh
DOTFILE_PATH=$(cd $(dirname $0) && pwd)

# update submodules
git submodule init
git submodule update

# set up vim files
ln -sf $DOTFILE_PATH/.vim/colors/molokai/colors/molokai.vim $DOTFILE_PATH/.vim/colors/molokai.vim

# set up oh-my-zsh files
rm -rf $DOTFILE_PATH/oh-my-zsh/custom
ln -sf $DOTFILE_PATH/oh-my-zsh/custom .oh-my-zsh/custom

# set up dotfiles
for dotfile in .?*
do
    if [ $dotfile != '..' ] && [ $dotfile != '.git' ]
    then
        ln -sf "$DOTFILE_PATH/$dotfile" $HOME
    fi
done

# todo: install go
# todo: install peco
