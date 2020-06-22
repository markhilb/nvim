"" General keybinds
" Keep selection when indenting/outdenting.
vnoremap > >gv
vnoremap < <gv

" Shift + j/k = jump 10 lines down/up
nnoremap <S-J> :+10<CR>
nnoremap <S-K> :-10<CR>

" Alt + j/k = move line down/up
nnoremap <A-j> :m.+1<CR>==
vnoremap <A-j> :m '>+1<CR>gv=gv
inoremap <A-j> <Esc>:m .+1<CR>==gi
nnoremap <A-k> :m.-2<CR>==
vnoremap <A-k> :m '<-2<CR>gv=gv
inoremap <A-k> <Esc>:m .-2<CR>==gi

" Tab = go to next tab
nnoremap <tab> :tabn<CR>

" Shift + tab = go to previous tab
nnoremap <S-tab> :tabp<CR>

" ; = execute previous command
nnoremap ; :<UP><CR>

" Wrap selected inside:
vnoremap ( d<ESC>i()<ESC>P
vnoremap [ d<ESC>i[]<ESC>P
vnoremap { d<ESC>i{}<ESC>P
vnoremap " d<ESC>i""<ESC>P
vnoremap ' d<ESC>i''<ESC>P

"Don't overwrite clipboard on visual paste
vnoremap p "_dP


"" Leader specific maps
" Set leader key to space
let mapleader = " "
set timeout ttimeoutlen=50 " Time before keykode or leader terminated

" <leader>w = save file
nnoremap <leader>w :w!<CR>

" <leader>l = unhighlight words
nnoremap <leader>l :noh<CR>

" <leader>p = :CtrlP (search file menu)
nnoremap <leader>p :CtrlP<CR>

" <leader>n = new tab
nnoremap <leader>n :tabedit<CR>

" <leader>t = new tab + :CtrlP (search file menu)
nnoremap <leader>t :tabedit<CR>:CtrlP<CR>

" <leader>e = new tab + file explorer
nnoremap <leader>e :tabedit<CR>:Explore<CR>

" <leader>i = fix file indentation
nnoremap <leader>i gg=G

" <leader>y = copy entire file
nnoremap <leader>y ggyG

" <leader>f = fix trailing whitespace
nnoremap <leader>f :FixWhitespace<CR>

" <leader>s = Insert emojis
nnoremap <leader>s :%s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g<CR>:noh<CR>

" <leader>r = Reverse search through previous : commands
nnoremap <leader>r q:?

" <leader>' = Replace all " with '
nnoremap <leader>' :%s /"/'/g<CR>

" <leader>" = Replace all ' with "
nnoremap <leader>" :%s /'/"/g<CR>

" <leader>b = :wa | sus (save all files and suspend vim session)
nnoremap <leader>b :wa \| sus<CR>

" Alt + {number} = go to that tab (alt + 0 goes to last tab)
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

