vim.cmd([[
    autocmd FileType c setlocal commentstring=//\ %s
    autocmd FileType cs setlocal commentstring=//\ %s
    autocmd FileType fsharp setlocal commentstring=//\ %s
]])
