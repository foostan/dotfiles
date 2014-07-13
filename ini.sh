#!/bin/sh
DOTFILE_PATH=$(cd $(dirname $0) && pwd)

# update submodules
git submodule init
git submodule update

# set up vim files
ln -sf $DOTFILE_PATH/.vim/colors/molokai/colors/molokai.vim $DOTFILE_PATH/.vim/colors/molokai.vim

# set up oh-my-zsh files
ln -sf $DOTFILE_PATH/ohmyzsh_myfiles/my.zsh .oh-my-zsh/custom/my.zsh
ln -sf $DOTFILE_PATH/ohmyzsh_myfiles/my.zsh-theme .oh-my-zsh/themes/my.zsh-theme
mv .oh-my-zsh/lib/termsupport.zsh .oh-my-zsh/lib/termsupport.zsh.del

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
