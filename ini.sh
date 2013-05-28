#!/bin/sh
cd $(dirname $0)
for dotfile in .?*
do
    if [ $dotfile != '..' ] && [ $dotfile != '.git' ]
    then
        ln -Fis "$PWD/$dotfile" $HOME
    fi
done
cd .vim/bundle/
git clone git://github.com/Shougo/neobundle.vim.git
git clone git://github.com/Shougo/vimproc.git
