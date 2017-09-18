set nocompatible
filetype off "required for vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'ervandew/supertab'
Plugin 'christoomey/vim-tmux-navigator'
call vundle#end()

"
"vundle setup end 
"
filetype plugin on

" Search down into subfolders
" Provide tab-completion for all file-related tasks
set path+=**

" enable file plugin
syntax enable

" Display all matching files when we tab complete
set wildmenu

set nu
set hlsearch
