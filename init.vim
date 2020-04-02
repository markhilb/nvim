call plug#begin()
	Plug 'rafi/awesome-vim-colorschemes'   "
	Plug 'sheerun/vim-polyglot'			   " Colorschemes + syntax highlighting
	Plug 'justinmk/vim-syntax-extra'	   "
	Plug 'octol/vim-cpp-enhanced-highlight'"
    Plug 'ap/vim-css-color'                " Display color of hex values

	Plug 'scrooloose/nerdtree' " Filetree
	Plug 'ctrlpvim/ctrlp.vim'  " Filesearching

	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Autocomplete menu

	Plug 'rhysd/accelerated-jk'

	Plug 'tpope/vim-commentary'

	Plug 'jiangmiao/auto-pairs' " Autoclose parentheses etc.
	Plug 'wellle/targets.vim'   " Target inside text objects
	Plug 'alvan/vim-closetag'   " Autoclose html tags

	Plug 'bronson/vim-trailing-whitespace'

	Plug 'junegunn/vim-emoji'
call plug#end()
packloadall


colorscheme custom

set clipboard=unnamedplus " Share vim clipboard with OS clipboard
set mouse=a				  " Use mouse in vim

syntax on
set number relativenumber
let g:deoplete#enable_at_startup=1
set completeopt=menu,noinsert   " Make autocomplete menu auto highlight first option

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


" Change vim-commentary to use // in c files
autocmd FileType c setlocal commentstring=//\ %s


" Keep selection when indenting/outdenting.
vnoremap > >gv
vnoremap < <gv

"shift + j/k = jump 10 lines down/up
nnoremap <S-J> :+10<CR>
nnoremap <S-K> :-10<CR>

"Alt + j/k = move line down/up
nnoremap <A-j> :m.+1<CR>==
vnoremap <A-j> :m '>+1<CR>gv=gv
inoremap <A-j> <Esc>:m .+1<CR>==gi
nnoremap <A-k> :m.-2<CR>==
vnoremap <A-k> :m '<-2<CR>gv=gv
inoremap <A-k> <Esc>:m .-2<CR>==gi

"tab = go to next tab
nnoremap <tab> :tabn<CR>

"shift + tab = go to previous tab
nnoremap <S-tab> :tabp<CR>

"; = execute previous command
nnoremap ; :<UP><CR>

"Wrap selected inside:
vnoremap ( d<ESC>i()<ESC>P
vnoremap [ d<ESC>i[]<ESC>P
vnoremap { d<ESC>i{}<ESC>P
vnoremap " d<ESC>i""<ESC>P
vnoremap ' d<ESC>i''<ESC>P

"Don't overwrite clipboard on visual paste
vnoremap p "_dP


" Leader specific maps
let mapleader = " "
" Time before keykode or leader terminated
set timeout ttimeoutlen=50

" w = save file
nnoremap <leader>w :w!<CR>

" l = unhighlight words
nnoremap <leader>l :noh<CR>

" p = :CtrlP (search file menu)
nnoremap <leader>p :CtrlP<CR>

" n = new tab
nnoremap <leader>n :tabedit<CR>

" t = new tab + :CtrlP (search file menu)
nnoremap <leader>t :tabedit<CR>:CtrlP<CR>

" e = open file in new tab
nnoremap <leader>e :tabfind 

" i = fix file indentation
nnoremap <leader>i gg=G

" y = copy entire file
nnoremap <leader>y ggyG

" f = fix trailing whitespace
nnoremap <leader>f :FixWhitespace<CR>

" s = Insert emojis
nnoremap <leader>s :%s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g<CR>:noh<CR>

" r = Reverse search through previous : commands
nnoremap <leader>r q:?

" ' = Replace all " with '
nnoremap <leader>' :%s /"/'/g<CR>

" " = Replace all ' with "
nnoremap <leader>" :%s /'/"/g<CR>


"ctr + {number} = go to that tab (ctr + 0 goes to last tab)
function Tabber1()
	for i in range(0, 10)
		if i == 0
			let s:cmd = 'nnoremap <A-' . 0 . '> ' . 1 . 'gt \| :tabp<CR>'
		else
			let s:cmd = 'nnoremap <A-' . i . '> ' . i . 'gt'
		endif
		execute s:cmd
	endfor
endfunction

call Tabber1()

