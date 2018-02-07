#!/bin/bash -x
HOME=$(echo ~)
VUNDLE_DIR="$HOME/.vim/bundle/Vundle.vim"
echo $VUNDLE_DIR
if [ ! -d $VUNDLE_DIR ]; then
    git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
fi
cp .vimrc ~
cp .tmux.conf ~
vim +PluginInstall
~/.vim/bundle/YouCompleteMe/install.sh --clang-complete
