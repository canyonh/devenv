#!/bin/bash -x
HOME=$(echo ~)

# utility
sudo apt-get install -y openssh-server apt-file silversearcher-ag
sudo apt-file update

# zsh
sudo apt-get install -y zsh fonts-powerline
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
echo "source $HOME/devenv/zsh/.zshrc" > ~/.zshrc

## tmux
sudo apt-get install -y tmux
if [ -f "${HOME}/.tmux.conf" ]; then
    cp ${HOME}/.tmux.conf ${HOME}/.tmux.conf.bak
fi

echo "source ~/devenv/tmux/.tmux.conf" > ${HOME}/.tmux.conf

echo "source $HOME/devenv/tmux/.tmux.conf" > ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/devenv/tmux/plugins/tpm

# ccls
sudo apt-get install -y cmake clang libclang-10-dev nodejs
pushd .
mkdir ~/source
cd ~/source
git clone --depth=1 --recursive https://github.com/MaskRay/ccls
cd ccls
cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=/usr/lib/llvm-10 -DLLVM_INCLUDE_DIR=/usr/lib/llvm-10/include -DLLVM_BUILD_INCLUDE_DIR=/usr/include/llvm-10/ && cd Release && sudo make install
popd

# git
git config --global user.email kxhuan@dolby.com
git config --global user.name kxhuan

if [ -f "${HOME}/.gitconfig" ]; then
    cp ${HOME}/.gitconfig ${HOME}/.gitconfig.bak
fi

if ! grep -q "[incude]" ${HOME}/.gitconfg ; then
    print "[include]\n\tpath=${HOME}/devenv/git/.gitconfig" >> $HOME/.gitconfig
fi

# neovim
sudo apt-get install -y neovim
if [ -f "${HOME}/.config/nvim/init.vim" ]; then
    cp ${HOME}/.config/nvim/init.vim ${HOME}/.config/nvim/init.vim.bak
fi

mkdir -p ${HOME}/.config/nvim
echo "source ~/devenv/nvim/init.vim" > ${HOME}/.config/nvim/init.vim

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim --headless +PlugInstall +qa

cp ${HOME}/devenv/coc.nvim/coc-settings.json ${HOME}/.config/nvim
