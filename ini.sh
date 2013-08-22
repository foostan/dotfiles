#!/bin/sh
cd $(dirname $0)
for dotfile in .?*
do
    if [ $dotfile != '..' ] && [ $dotfile != '.git' ]
    then
        ln -s "$PWD/$dotfile" $HOME
    fi
done
cd .vim/bundle/
git clone git://github.com/Shougo/neobundle.vim.git
git clone git://github.com/Shougo/vimproc.git

cd ~/
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
ln -s ~/dotfiles/oh-my-zsh/my.zsh ~/.oh-my-zsh/custom/
ln -s ~/dotfiles/oh-my-zsh/my.zsh-theme ~/.oh-my-zsh/themes/
