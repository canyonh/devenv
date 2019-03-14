#!/bin/bash -x
# installs necessary files onto dev machine. TODO Mac OSX support is not complete
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
	sudo apt-get install -y build-essential cmake
	sudo apt-get install -y python-dev python3-dev
    sudo apt-get install powerline fonts-powerline python-powerline python3-powerline
fi

# install plugin silently
echo | echo | vim +PluginInstall +qall &>/dev/null
#vim +PluginInstall

$HOME/.vim/bundle/YouCompleteMe/install.py --clang-complete
printf "let g:ycm_global_ycm_extra_conf = '$HOME/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'\n" >> ~/devenv/vim/.vimrc

#zsh
if [[ "$platform" == 'linux' ]]; then
	sudo apt-get -y install zsh 
else
	brew install zsh
fi
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "source $HOME/devenv/zsh/.zshrc" > ~/.zshrc
echo "source $HOME/devenv/tmux/.tmux.conf" > ~/.tmux.conf

#gdb pretty printers
(mkdir ~/gdb_printers; cd gdb_printers && svn co svn://gcc.gnu.org/svn/gcc/trunk/libstdc++-v3/python)
printf "python\nimport sys\nsys.path.insert(0, '/home/maude/gdb_printers/python')\nfrom libstdcxx.v6.printers import register_libstdcxx_printers\nregister_libstdcxx_printers (None)\nend" > ~/.gdbinit

