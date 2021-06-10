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

" // = Search for highlighted text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

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

" <leader>g = Fzf grep search
nnoremap <leader>g :AgSearch<CR>

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
nnoremap <silent><leader>f :mark q \| FixWhitespace<CR> 'q :w<CR>

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

" <leader>a = Format
nnoremap <leader>a :Format<CR>

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
    execute 'Files' git_root
endfunction
command! FZFSearch execute s:fzf_find_files()

" Function to make Ag search from git root if in git repo.
" Else, search from current directory
" (also rebind select/deselect all bindings to ctrl-a/ctrl-d)
function! s:ag_search(bang)
    let git_root = system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
    call fzf#vim#ag(join(a:000[1:], ' '),
                  \ '--hidden --ignore-dir={node_modules,.git,target,bin,obj}',
                  \ fzf#vim#with_preview({'dir': git_root,
                                        \ 'options': '--bind ctrl-a:select-all,ctrl-d:deselect-all'}),
                  \ a:bang)
endfunction
command! -bang -complete=dir AgSearch call s:ag_search(<bang>0)

" Use correct formatter depending on filetype
function! s:format()
    execute 'w'
    let filetype = &filetype
    if filetype == 'fsharp'
        execute 'silent !fantomas %'
        execute 'e'
    elseif filetype == 'rust'
        execute 'silent !rustfmt %'
        execute 'e'
    else
        execute 'PrettierAsync'
    endif
endfunction
command! Format call s:format()
