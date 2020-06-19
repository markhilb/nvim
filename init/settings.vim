colorscheme custom

set clipboard=unnamedplus " Share vim clipboard with OS clipboard
set mouse=a				  " Use mouse in vim

syntax on
set number relativenumber
let g:deoplete#enable_at_startup=1
set completeopt=menu,noinsert   " Make autocomplete menu auto highlight first option

" CtrlP settings
" let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
" let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_files=0 " Remove CtrlP max number of files limit
let g:ctrlp_custom_ignore = '\v[\/](node_modules)$'

" Ctr + a = Bring out emoji menu
set completefunc=emoji#complete
inoremap <C-a> <C-x><C-u>


set tabstop=4	  "
set expandtab     " Configure tabsize = 4
set softtabstop=4 " and use spaces instead of tabs
set shiftwidth=4  "


" silent! helptags ALL " ?????


set noswapfile

" Allow larger undo history
set undofile                       " use an undo file
set undodir=$HOME/.vim/undo        " undo file path
set undolevels=1000
set undoreload=10000


" Vim commentary settings
autocmd FileType c setlocal commentstring=//\ %s " Use // in c files
autocmd FileType cs setlocal commentstring=//\ %s " Use // in c# files

