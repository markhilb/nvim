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
set mouse=a
syntax on
colorscheme custom
"set t_Co=256
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
"Alt + j = move line down
nnoremap <A-j> :m.+1<CR>==
vnoremap <A-j> :m '>+1<CR>gv=gv
inoremap <A-j> <Esc>:m .+1<CR>==gi
"Alt + k = move line up
nnoremap <A-k> :m.-2<CR>==
vnoremap <A-k> :m '<-2<CR>gv=gv
inoremap <A-k> <Esc>:m .-2<CR>==gi
"; = execute previous command
nnoremap ; :<UP><CR>

"ctr + {number} = go to that tab (ctr + 0 goes to last tab)
function Tabber()
	for i in range(0, 10)
		if i == 0
			let s:cmd = 'nnoremap <A-' . 0 . '> ' . 1 . 'gt \| :tabp<CR>'
		else
			let s:cmd = 'nnoremap <A-' . i . '> ' . i . 'gt'
		endif
		execute s:cmd
	endfor
endfunction

call Tabber()



