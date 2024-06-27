return {
    'tpope/vim-commentary',
    config = function()
        vim.cmd([[
            autocmd FileType c setlocal commentstring=//\ %s
            autocmd FileType cs setlocal commentstring=//\ %s
            autocmd FileType fsharp setlocal commentstring=//\ %s
        ]])
    end,
}
