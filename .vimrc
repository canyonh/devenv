set nocompatible
filetype off "required for vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
"Plugin 'davidhalter/jedi-vim'
Plugin 'christoomey/vim-tmux-navigator'
"Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'
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

"set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
set tabstop=4 softtabstop=0 shiftwidth=4 smarttab

" case insensitive search
set ignorecase

" leader k for nerd tree
nmap <leader>k :NERDTreeToggle<cr>

let g:ycm_global_ycm_extra_conf = '/home/kxhuan/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

"set jedi-vim auto completion to contrl-N since ctrl-space is switching input
"methods

"let g:jedi#completions_command = "<C-N>"

"syntatic recommend settings
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
