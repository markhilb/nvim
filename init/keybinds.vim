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

" <leader>p = :FZFSearch
nnoremap <leader>p :FZFSearch<CR>
" <leader>P = :Files
nnoremap <leader>P :Files .<CR>

" <leader>g = Fzf grep search
nnoremap <leader>g :AgSearch<CR>
" <leader>G = Fzf grep search from current directory
nnoremap <leader>G :Ag<CR>

" <leader>n = new tab
nnoremap <silent><leader>n :tabedit<CR>

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

" <leader>o = Open quick fix list
nnoremap <leader>o :copen<CR>


"" Omnisharp
augroup omnisharp_commands
  autocmd!

  autocmd CursorHold *.cs OmniSharpTypeLookup

  autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
  autocmd FileType cs nmap <silent> <buffer> gp <Plug>(omnisharp_preview_definition)
  autocmd FileType cs nmap <silent> <buffer> gf <Plug>(omnisharp_find_usages)
  autocmd FileType cs nmap <silent> <buffer> <Leader>opi <Plug>(omnisharp_preview_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ot <Plug>(omnisharp_type_lookup)
  autocmd FileType cs nmap <silent> <buffer> <Leader>od <Plug>(omnisharp_documentation)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ofs <Plug>(omnisharp_find_symbol)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ou <Plug>(omnisharp_fix_usings)
  autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
  autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

  autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
  autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)

  autocmd FileType cs nmap <silent> <buffer> <Leader>oc <Plug>(omnisharp_global_code_check)
  autocmd FileType cs nmap <silent> <buffer> <Leader>oc <Plug>(omnisharp_global_code_check)

  autocmd FileType cs nmap <silent> <buffer> <Leader>oa <Plug>(omnisharp_code_actions)
  autocmd FileType cs xmap <silent> <buffer> <Leader>oa <Plug>(omnisharp_code_actions)

  autocmd FileType cs nmap <silent> <buffer> <Leader>o. <Plug>(omnisharp_code_action_repeat)
  autocmd FileType cs xmap <silent> <buffer> <Leader>o. <Plug>(omnisharp_code_action_repeat)

  autocmd FileType cs nmap <silent> <buffer> <Leader>or <Plug>(omnisharp_rename)

  autocmd FileType cs nmap <silent> <buffer> <Leader>osr <Plug>(omnisharp_restart_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>oss <Plug>(omnisharp_start_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osp <Plug>(omnisharp_stop_server)
augroup END

"" COC

" Open CocConfig
nmap <leader>cc :CocConfig<CR>

" Use <C-SPACE> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `gn` and `gN` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> gn <Plug>(coc-diagnostic-next)
nmap <silent> gN <Plug>(coc-diagnostic-prev)
nmap <leader>cd  :CocList diagnostics<CR>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt :call CocAction('jumpDefinition', 'tab drop')<CR>
nmap <silent> gp :call CocAction('jumpDefinition', v:false)<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use gt to show documentation in preview window.
nnoremap <leader>ct :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Symbol renaming.
nmap <leader>cr <Plug>(coc-rename)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>ca  <Plug>(coc-codeaction-selected)
nmap <leader>ca  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>cag  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>cf  <Plug>(coc-fix-current)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:OR` command for organize imports of the current buffer.
nmap <leader>ci   :call     CocAction('runCommand', 'editor.action.organizeImport')<CR>

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


nmap <leader>cl :CocList<CR>
" Mappings for CoCList
" Show all diagnostics.
" nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions.
" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" " Show commands.
" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document.
" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols.
" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list.
" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>



" Function to make FZF search from git root if in git repo.
" Else, search from current directory
function! s:fzf_find_files()
    let git_root = system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
    execute 'Files' git_root
endfunction
command! FZFSearch execute s:fzf_find_files()

" Function to make Ag search from git root if in git repo.
" Else, search from current directory
function! s:ag_search(bang)
    let git_root = system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
    call fzf#vim#ag(join(a:000[1:], ' '),
                  \ fzf#vim#with_preview({'dir': git_root}),
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
    elseif filetype == 'cs'
        execute 'OmniSharpCodeFormat | w'
    elseif filetype == 'rust'
        execute 'silent !rustfmt %'
        execute 'e'
    else
        execute 'PrettierAsync'
    endif
endfunction
command! Format call s:format()
