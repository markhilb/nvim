require('nvim-treesitter.configs').setup({
    ensure_installed = 'all',
    highlight = { enable = true },
    autotag = { enable = true },
})

vim.keymap.set('n', '<leader>H', ':TSHighlightCapturesUnderCursor<CR>', { silent = true })
