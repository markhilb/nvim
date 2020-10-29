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

" Explore (netrw)
let g:netrw_keepdir=0 " Need this to duplicate files in netrw

"" Deoplete settings
let g:deoplete#enable_at_startup=1
set completeopt=menu,noinsert      " Make autocomplete menu auto highlight first option


"" FZF settings
" Customize fzf search function to ignore folders and show hidden files
let $FZF_DEFAULT_COMMAND = 'find . -type d \( -name node_modules -o
                                           \ -name .git -o
                                           \ -name bin -o
                                           \ -name obj
                                           \ \) -prune -o -print'

"" Emoji settings
set completefunc=emoji#complete
" Ctr + a = Bring out emoji menu
inoremap <C-a> <C-x><C-u>


"" EasyMotion settings
let g:EasyMotion_do_mapping = 0 " Disable all default mappings
let g:EasyMotion_smartcase = 1 " Ignore cases
let g:EasyMotion_keys = get(
    \ g:, 'EasyMotion_keys', 'asdghklqwertyuiopcvbnmfj') " Define the keys used


"" Vim commentary settings
autocmd FileType c setlocal commentstring=//\ %s  " Use // in c files
autocmd FileType cs setlocal commentstring=//\ %s " Use // in c# files

