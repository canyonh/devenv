set nocompatible
filetype off "required for vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'christoomey/vim-tmux-navigator'
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

set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
"set tabstop=4 softtabstop=0 shiftwidth=4 smarttab

" case insensitive search
set ignorecase

" don't open window on first match
let g:EasyGrepOpenWindowOnMatch=0

" leader k for nerd tree
nmap <leader>k :NERDTreeToggle<cr>

" YCM
set encoding=utf-8
" will be added later by bootstrap.sh
" let g:ycm_global_ycm_extra_conf = '/home/kxhuan/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_show_diagnostics_ui = 0

nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>

"The Silver Searcher
if executable('ag')
	" Use ag over grep
	set grepprg=ag\ --nogroup\ --nocolor

	" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

	"ag is fast enough that CtrlP doesn't need to cache
	let g:ctrlp_use_caching = 0
endif
