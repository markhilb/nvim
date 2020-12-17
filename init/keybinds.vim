"" General keybinds
" Keep selection when indenting/outdenting.
vnoremap > >gv
vnoremap < <gv

" Shift + j/k = jump 10 lines down/up
nnoremap <S-J> 10j
nnoremap <S-K> 10k

" Alt + j/k = move line down/up
nnoremap <A-j> :m.+1<CR>==
vnoremap <A-j> :m '>+1<CR>gv=gv
inoremap <A-j> <Esc>:m .+1<CR>==gi
nnoremap <A-k> :m.-2<CR>==
vnoremap <A-k> :m '<-2<CR>gv=gv
inoremap <A-k> <Esc>:m .-2<CR>==gi

" t = go to next tab
nnoremap t :tabn<CR>

" Shift + t = go to previous tab
nnoremap <S-t> :tabp<CR>

" ; = execute previous command
nnoremap ; :<UP><CR>

" Wrap selected inside:
vnoremap ( d<ESC>i()<ESC>P
vnoremap [ d<ESC>i[]<ESC>P
vnoremap { d<ESC>i{}<ESC>P
vnoremap " d<ESC>i""<ESC>P
vnoremap ' d<ESC>i''<ESC>P

" Don't overwrite clipboard on visual paste
vnoremap p "_dP

" Don't go to next word when highlighting
nnoremap <silent>* :execute "normal! *N"<CR>
nnoremap <silent># :execute "normal! #N"<CR>

" Open vim easymotion
nmap r <Plug>(easymotion-overwin-f)

"" Leader specific maps
" Set leader key to space
let mapleader = " "
set timeout ttimeoutlen=50 " Time before keykode or leader terminated

" <leader>w = save file
nnoremap <leader>w :w!<CR>

" <leader>l = unhighlight words
nnoremap <leader>l :noh<CR>

" <leader>p = :FZFSearch (search file menu)
nnoremap <leader>p :FZFSearch<CR>

" <leader>g = Fzf grep search (also rebind select/deselect all bindings to ctrl-a/ctrl-d)
nnoremap <leader>g :call fzf#vim#ag('', '--hidden', {'options': '--bind ctrl-a:select-all,ctrl-d:deselect-all'})<CR>

" <leader>n = new tab
nnoremap <leader>n :tabedit<CR>

" <leader>e = new tab + file explorer
nnoremap <leader>e :tabedit<CR>:Explore<CR>

" <leader>E = file explorer
nnoremap <leader>E :Explore<CR>

" <leader>i = fix file indentation
nnoremap <leader>i gg=G

" <leader>y = copy entire file
nnoremap <leader>y ggyG

" <leader>f = fix trailing whitespace
nnoremap <leader>f :mark q \| FixWhitespace<CR> 'q

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

" <leader>B = :BlamerToggle
nnoremap <leader>B :BlamerToggle<CR>

" <leader>a = PrettierAsync
nnoremap <leader>a :PrettierAsync<CR>

" <leader>h = Horisontal split into blank document
nnoremap <leader>h :new<CR><C-w>r

" <leader>v = Vertical split into blank document
nnoremap <leader>v :vnew<CR><C-w>r

" <leader><arrow-key> = Navigate vim splits
nnoremap <leader><Up> <C-w><Up>
nnoremap <leader><Down> <C-w><Down>
nnoremap <leader><Left> <C-w><Left>
nnoremap <leader><Right> <C-w><Right>

" Function to make FZF search from git root if in git repo.
" Else, search from current directory
function! s:fzf_find_files()
    let git_root = system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
    if git_root != ''
        execute 'Files' git_root
    else
        execute 'Files'
    endif
endfunction
command! FZFSearch execute s:fzf_find_files()


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

