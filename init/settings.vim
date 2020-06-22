"" General settings
colorscheme custom
syntax on
set mouse=a				  " Use mouse in vim
set clipboard=unnamedplus " Share vim clipboard with OS clipboard
set number relativenumber " Line numbers are relative to current line

" Indentation
set tabstop=4	  "
set expandtab     " Configure tabsize = 4
set softtabstop=4 " and use spaces instead of tabs
set shiftwidth=4  "

" Swap/undo
set noswapfile              " Do not create swap files
set undofile                " Use an undo file
set undodir=$HOME/.vim/undo " Undo file path
set undolevels=1000         " Allow larger undo history
set undoreload=10000


"" Deoplete settings
let g:deoplete#enable_at_startup=1
set completeopt=menu,noinsert      " Make autocomplete menu auto highlight first option


"" CtrlP settings
let g:ctrlp_show_hidden=1                           " Show hidden files
let g:ctrlp_max_files=0                             " Remove CtrlP max number of files limit
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
let g:ctrlp_custom_ignore = '\v[\/](node_modules)$'


"" Emoji settings
set completefunc=emoji#complete
" Ctr + a = Bring out emoji menu
inoremap <C-a> <C-x><C-u>


"" Vim commentary settings
autocmd FileType c setlocal commentstring=//\ %s  " Use // in c files
autocmd FileType cs setlocal commentstring=//\ %s " Use // in c# files

