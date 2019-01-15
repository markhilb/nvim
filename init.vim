call plug#begin()
	Plug 'kien/ctrlp.vim'
	Plug 'scrooloose/nerdtree'
	Plug 'octol/vim-cpp-enhanced-highlight'
	Plug 'jiangmiao/auto-pairs'
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'rafi/awesome-vim-colorschemes'
	Plug 'rhysd/accelerated-jk'

	
call plug#end()
set tabstop=4
set shiftwidth=4
set clipboard=unnamedplus
set number relativenumber
syntax on
colorscheme space-vim-dark
"set t_Co=256
"colorscheme abstract
"highlight Normal ctermbg=black
"highlight Normal ctermfg=black
let g:deoplete#enable_at_startup = 1
packloadall
silent! helptags ALL

ALEToggle

"Key bindings:
"
"
"ctr + l = unhighlight words
nnoremap <silent> <C-l> :nohl<CR><C-l>
"ctr + n = new tab
nnoremap <C-n> :tabedit<CR>
"tab = go to next tab
nnoremap <tab> :tabn<CR>
"shift + tab = go to previous tab
nnoremap <S-tab> :tabp<CR>
"shift + j = jump half page down
nnoremap <S-J> <C-D>                                                        
"shift + k = jump half page up
nnoremap <S-K> <C-U>   
