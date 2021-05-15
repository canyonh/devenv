call plug#begin()
Plug 'will133/vim-dirdiff'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-signify'
Plug 'tomasr/molokai'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'
Plug 'jiangmiao/auto-pairs'
Plug 'rhysd/vim-clang-format'
"Plug 'puremourning/vimspector'
call plug#end()

"-------------------------------------------------
" General preferences
"-------------------------------------------------

" Display all matching files when we tab complete
set wildmenu
set number
set ruler
set hlsearch

set tabstop=4 softtabstop=0 shiftwidth=4 smarttab
"set expandtab
"set tabstop=4 softtabstop=0 shiftwidth=4 smarttab

" always show current cursorline
set cursorline

" dark background
set background=dark

" set indent smart
set smartindent autoindent

" case insensitive search
set ignorecase

" Use true color
if (has("termguicolors"))
  set termguicolors
endif
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" auto source when writing to init.vm alternatively you can run :source $MYVIMRC
" Does not seem to work
au! BufWritePost $MYVIMRC source %      

" Turn syntax on
syntax enable

" color scheme
colorscheme molokai

" Resize windows
nnoremap <M-j> :resize +2<CR>
nnoremap <M-k> :resize -2<CR>
nnoremap <M-h> :vertical resize +2<CR>
nnoremap <M-l> :vertical resize -2<CR>

"-------------------------------------------------
" vpp-cpp-enhanced-highlight
"-------------------------------------------------
"let g:cpp_class_scope_highlight = 1
"let g:cpp_member_variable_highlight = 1
"let g:cpp_posix_standard = 1

"-------------------------------------------------
" vpp-cpp-enhanced-highlight
"-------------------------------------------------
"let g:vimspector_enable_mappings = 'HUMAN'
"let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools']


"-------------------------------------------------
" sync javascript highlights, ref https://thoughtbot.com/blog/modern-typescript-and-react-development-in-vim
"-------------------------------------------------
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

"-------------------------------------------------
" Coc-explorer
"-------------------------------------------------
nmap <leader>k : CocCommand explorer<cr>

"-------------------------------------------------
" clang format
"-------------------------------------------------
nnoremap <Leader>f: <C-u>ClangFormat<CR>

"-------------------------------------------------
" Termdebug
"-------------------------------------------------

" add terminal debug package
packadd termdebug

" to know conbination of function keys press the key in command mode (:) then
" the corresponding function key will show. for example shift function keys
" are + 12 (e.g. shift F6 -> F18)
let g:termdebug_wide = 163
nnoremap <F5> :Run<CR>
" Shift-F5
nnoremap <F17> :call TermDebugSendCommand('quit')<CR>

nnoremap <F6> :Over<CR>
" shift-F6
nnoremap <F18> :Step<CR>
nnoremap <F7> :Finish<CR>

nnoremap <F8> :Break<CR>
" shift F8
nnoremap <F20> :Clear<CR>

nnoremap <F9> :Continue<CR>

"-------------------------------------------------
" FZF Shortcuts for open and searching
"-------------------------------------------------
" ctrl-p for file searching
nmap <C-p> :Files<cr>

" ctrl-f for finding in files
nmap <C-n> :Ag<cr>

" popup window
"let g:fzf_layout = { 'window': {'width': 0.9, 'height': 0.6 }}
" down 40%
let g:fzf_layout = { 'down': '40%' }


"-------------------------------------------------
" Powerline
"-------------------------------------------------

"power line fonts
let g:airline_powerline_fonts = 1 
let g:airline_theme='simple'

"-------------------------------------------------
"singify
"-------------------------------------------------
let g:signify_vcs_list = [ 'git', 'perforce' ]

"-------------------------------------------------
" c++ syntax highlighting
"-------------------------------------------------
"let g:cpp_class_scope_highlight = 1
"let g:cpp_member_variable_highlight = 1
"let g:cpp_class_decl_highlight = 1
"let g:lsp_cxx_hl_use_text_props=1

"-------------------------------------------------
" clang formt
"-------------------------------------------------
"let g:clang_format#detect_style_file = 1
"autocmd FileType c,cpp ClangFormatAutoEnable

"-------------------------------------------------
" coc.nvim
"-------------------------------------------------
let g:coc_global_extensions = [
    \ 'coc-tsserver',
    \ 'coc-pyright',
    \ 'coc-json',
    \ 'coc-css',
    \ 'coc-tsserver',
    \ 'coc-prettier',
    \ 'coc-eslint' ,
    \ 'coc-explorer',
    \ 'coc-java'
    \ ]

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>d  :<C-u>CocList diagnostics<cr>
" Manage extensions
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

