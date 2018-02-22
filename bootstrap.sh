#!/bin/bash -x
HOME=$(echo ~)

platform='unknown'
unamestr="$(uname)"
if [[ "$unamestr" == 'Linux' ]]; then
	platform='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
	platform='freebsd'
fi

#vim
echo "source $HOME/devenv/vim/.vimrc" > ~/.vimrc 
VUNDLE_DIR="$HOME/.vim/bundle/Vundle.vim"
echo $VUNDLE_DIR
if [ ! -d $VUNDLE_DIR ]; then
    git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
fi

if [[ "$platform" == 'linux' ]]; then
	sudo apt-get install build-essential cmake
	sudo apt-get install python-dev python3-dev
fi

# install plugin silently
#echo | echo | vim +PluginInstall +qall &>/dev/null
vim +PluginInstall
$HOME/.vim/bundle/YouCompleteMe/install.py --clang-complete

#zsh
if [[ "$platform" == 'linux' ]]; then
	sudo apt-get -y install zsh 
else
	brew install zsh
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "source $HOME/devenv/zsh/.zshrc" > ~/.zshrc
echo "source $HOME/devenv/tmux/.tmux.conf" > ~/.tmux.conf
