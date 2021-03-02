#!/bin/bash -x
HOME=$(echo ~)

set -e

#---------------------------------------- 
# utility
#---------------------------------------- 
sudo apt update 
sudo apt install -y curl openssh-server silversearcher-ag

#---------------------------------------- 
# zsh
#----------------------------------------
sudo apt-get install -y zsh fonts-powerline
if [ "$(which zsh)" != "$(which $SHELL)" ]; then
    chsh -s $(which zsh)
    echo "Change shell to zsh. Need to relogin and change shells"
    gnome-session-quit
    exit 0
fi

# todo create a copy instead of skip
if [ -d ${HOME}/.oh-my-zsh ]; then
    rm -rf ${HOME}/.oh-my-zsh.bak
    mv ${HOME}/.oh-my-zsh ${HOME}/.oh-my-zsh.bak
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
if [ -f ${HOME}/.zshrc ]; then
    rm -rf ${HOME}/.zshrc.bak
    mv ${HOME}/.zshrc ${HOME}/zshrc.bak
fi
 
echo "source $HOME/devenv/zsh/.zshrc" > ${HOME}/.zshrc

#---------------------------------------- 
# tmux
#---------------------------------------- 
sudo apt-get install -y tmux
if [ -f "${HOME}/.tmux.conf" ]; then
    rm -rf ${HOME}/.tmux.conf.bak
    mv ${HOME}/.tmux.conf ${HOME}/.tmux.conf.bak
fi
echo "source ~/devenv/tmux/.tmux.conf" > ${HOME}/.tmux.conf
echo "source $HOME/devenv/tmux/.tmux.conf" > ~/.tmux.conf

if [ -d "${HOME}/devenv/tmux/plugins/tpm" ]; then
    rm -rf ${HOME}/devenv/tmux/plugins/tpm.bak
    mv ${HOME}/devenv/tmux/plugins/tpm ${HOME}/devenv/tmux/plugins/tpm.bak
fi
git clone https://github.com/tmux-plugins/tpm ~/devenv/tmux/plugins/tpm

#---------------------------------------- 
# set nodejs install version to 12.x LTS
#---------------------------------------- 
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt update
sudo apt install -y nodejs

#---------------------------------------- 
# ccls
#---------------------------------------- 
if [ -f /usr/local/bin/ccls ]; then
    sudo rm -f /usr/local/bin/ccls.bak
    sudo mv /usr/local/bin/ccls /usr/local/bin/ccls.bak
fi

sudo apt-get install -y cmake clang libclang-10-dev
pushd .

mkdir -p ~/source
cd ~/source

if [ -d ${HOME}/source/ccls ]; then
    rm -rf ccls.bak
    mv ccls ccls.bak
fi

git clone --depth=1 --recursive https://github.com/MaskRay/ccls
cd ccls
cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=/usr/lib/llvm-10 -DLLVM_INCLUDE_DIR=/usr/lib/llvm-10/include -DLLVM_BUILD_INCLUDE_DIR=/usr/include/llvm-10/ && cd Release && sudo make install
popd


#---------------------------------------- 
# neovim
#---------------------------------------- 
sudo apt-get install -y neovim

if [ -d ${HOME}/.config/nvim ]; then
    rm -rf ${HOME}/.config/nvim.bak
    mv ${HOME}/.config/nvim ${HOME}/.config/nvim.bak
fi

mkdir -p ${HOME}/.config/nvim
echo "source ~/devenv/nvim/init.vim" > ${HOME}/.config/nvim/init.vim

if [ -f "${HOME}/.config/nvim/coc-settings.json " ]; then
    rm ${HOME}/.config/nvim/coc-settings.json.bak
    mv ${HOME}/.config/nvim/coc-settings.json ${HOME}/.config/nvim/coc-settings.json.bak
fi

ln -s ${HOME}/devenv/coc.nvim/coc-settings.json ${HOME}/.config/nvim/coc-settings.json
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim --headless +PlugInstall +qa

sudo npm install -g neovim
sudo npm install -g bash-language-server 

#---------------------------------------- 
# coc-pyrght support 
#---------------------------------------- 
sudo apt install -y python3 python3-pip
pip3 install --user pynvim --upgrade
pip3 install --user pipenv --upgrade

# create .pylintrc file
if [ -f "$HOME/.pylintrc" ]; then
    rm $HOME/.pylintrc.bak
    mv $HOME/.pylintrc $HOME/.pylintrc.bak
fi

cat <<EOF >> $HOME/.pylintrc
init-hook=
    try: import pylint_venv
    except ImportError: pass
else: pylint_venv.inithook()
EOF

#---------------------------------------- 
# git
#---------------------------------------- 
git config --global user.email kxhuan@dolby.com
git config --global user.name kxhuan
git config --global diff.tool vimdiff
git config --global merge.tool vimdiff

if [ -f "${HOME}/.gitconfig" ]; then
    cp ${HOME}/.gitconfig ${HOME}/.gitconfig.bak
else
    touch ${HOME}/.gitconfig
fi

if [ ! grep -q "[incude]" ${HOME}/.gitconfig ]; then
    print "[include]\n\tpath=${HOME}/devenv/git/.gitconfig" >> $HOME/.gitconfig
fi

# ccache & distcc client @TODO setup environment
sudo apt-get install ccache
sudo apt-get install distcc
