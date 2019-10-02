call plug#begin()
	Plug 'ctrlpvim/ctrlp.vim'
	" Plug 'kien/ctrlp.vim'
	Plug 'scrooloose/nerdtree'
	Plug 'octol/vim-cpp-enhanced-highlight'
	Plug 'jiangmiao/auto-pairs'
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'rafi/awesome-vim-colorschemes'
	Plug 'rhysd/accelerated-jk'
	Plug 'terryma/vim-multiple-cursors'
	Plug 'tpope/vim-commentary'
	Plug 'sheerun/vim-polyglot'
	Plug 'wellle/targets.vim'
	Plug 'justinmk/vim-syntax-extra'
call plug#end()

colorscheme custom
	
set clipboard=unnamedplus
set mouse=a

syntax on
set tabstop=4
set shiftwidth=4
set number relativenumber
let g:deoplete#enable_at_startup=1
packloadall
silent! helptags ALL
set noswapfile


"Make autocomplete menu auto highlight first option
set completeopt=menu,noinsert


" Allow larger undo history
set undofile                       " use an undo file
set undodir=$HOME/.vim/undo        " undo file path
set undolevels=1000
set undoreload=10000


" Keep selection when indenting/outdenting.
vnoremap > >gv
vnoremap < <gv

"shift + j = jump 10 lines down
nnoremap <S-J> :+10<CR>

"shift + k = jump 10 lines up
nnoremap <S-K> :-10<CR>

"Alt + j = move line down
nnoremap <A-j> :m.+1<CR>==
vnoremap <A-j> :m '>+1<CR>gv=gv
inoremap <A-j> <Esc>:m .+1<CR>==gi

"Alt + k = move line up
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

" l = unhighlight words
nnoremap <leader>l :noh<CR>

" t = new tab + ctr + P
nnoremap <leader>t :tabedit<CR>:CtrlP<CR>

" n = new tab
nnoremap <leader>n :tabedit<CR>

" e = new tab + :e 
nnoremap <leader>e :tabedit<CR>:e 

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


