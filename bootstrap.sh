#!/bin/bash -x
HOME=$(echo ~)

set -o nounset
set -o errexit
set -e

#---------------------------------------- 
# utility
#---------------------------------------- 
sudo apt-get install -y openssh-server apt-file silversearcher-ag
sudo apt-file update

#---------------------------------------- 
# zsh
#---------------------------------------- 
sudo apt-get install -y zsh fonts-powerline
if [ ! -d /home/kxhuan/.oh-my-zsh]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
    echo "source $HOME/devenv/zsh/.zshrc" > ~/.zshrc
fi

#---------------------------------------- 
# tmux
#---------------------------------------- 
sudo apt-get install -y tmux
if [ -f "${HOME}/.tmux.conf" ]; then
    cp ${HOME}/.tmux.conf ${HOME}/.tmux.conf.bak
fi

echo "source ~/devenv/tmux/.tmux.conf" > ${HOME}/.tmux.conf
echo "source $HOME/devenv/tmux/.tmux.conf" > ~/.tmux.conf

if [! -d "${HOME}/dev/tmux/plugins/tpm"]; then
    git clone https://github.com/tmux-plugins/tpm ~/devenv/tmux/plugins/tpm
fi

#---------------------------------------- 
# set nodejs install version to 12.x LTS
#---------------------------------------- 
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt update
sudo apt install -y nodejs

#---------------------------------------- 
# ccls
#---------------------------------------- 
if [ ! -f /usr/local/bin/ccls ]; then
    sudo apt-get install -y cmake clang libclang-10-dev
    pushd .
    mkdir ~/source
    cd ~/source
    if [ -d ${HOME}/source/ccls ]; then
        mv ccls ccls_bak
    fi
    git clone --depth=1 --recursive https://github.com/MaskRay/ccls
    cd ccls
    cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=/usr/lib/llvm-10 -DLLVM_INCLUDE_DIR=/usr/lib/llvm-10/include -DLLVM_BUILD_INCLUDE_DIR=/usr/include/llvm-10/ && cd Release && sudo make install
    popd
fi

#---------------------------------------- 
# git
#---------------------------------------- 
git config --global user.email kxhuan@dolby.com
git config --global user.name kxhuan

if [ -f "${HOME}/.gitconfig" ]; then
    cp ${HOME}/.gitconfig ${HOME}/.gitconfig.bak
else
    touch ${HOME}/.gitconfig
fi

if [! grep -q "[incude]" ${HOME}/.gitconfig] ; then
    print "[include]\n\tpath=${HOME}/devenv/git/.gitconfig" >> $HOME/.gitconfig
fi

#---------------------------------------- 
# neovim
#---------------------------------------- 
sudo apt-get install -y neovim
if [ -f "${HOME}/.config/nvim/init.vim" ]; then
    cp ${HOME}/.config/nvim/init.vim ${HOME}/.config/nvim/init.vim.bak
fi

if [ ! -d ${HOME}/.config/nvim ]; then
    mkdir -p ${HOME}/.config/nvim
    echo "source ~/devenv/nvim/init.vim" > ${HOME}/.config/nvim/init.vim
fi

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim --headless +PlugInstall +qa

if [ ! -f "${HOME}/devenv/coc.nvim/coc-settings.json" ]; then
    ${HOME}/devenv/coc.nvim/coc-settings.jsonln -s ${HOME}/devenv/coc.nvim/coc-settings.json ${HOME}/.config/nvim/coc-settings.json
fi

sudo npm install -g neovim

#---------------------------------------- 
# coc-pyrght support 
#---------------------------------------- 
sudo apt install -y python3 python3-pip
pip3 install --user pynvim --upgrade
pip3 install --user pipenv --upgrade

# create .pylintrc file
if [ ! -f "$HOME/.pylintrc" ]; then
cat <<EOF >> $HOME/.pylintrc
init-hook=
    try: import pylint_venv
    except ImportError: pass
else: pylint_venv.inithook()
EOF
fi

# ccache & distcc client @TODO setup environment
sudo apt-get install ccache
sudo apt-get install distcc
