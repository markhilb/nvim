return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'nvim-treesitter/playground',
    },
    config = function()
        require('nvim-treesitter.configs').setup({
            auto_install = true,
            highlight = { enable = true },
        })

        vim.keymap.set('n', '<leader>H', ':TSHighlightCapturesUnderCursor<CR>', { silent = true })
        vim.cmd([[ :TSUpdate ]])
    end,
}
