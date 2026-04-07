return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    keys = {
        { '<leader>H', ':Inspect<CR>', { silent = true } },
    },
    config = function()
        require('nvim-treesitter').setup({
            highlight = { enable = true },
        })

        vim.api.nvim_create_autocmd('FileType', {
            callback = function()
                local ft = vim.bo.filetype
                local lang = vim.treesitter.language.get_lang(ft)
                if #vim.treesitter.query.get_files(lang, 'highlights') > 0 then
                    vim.treesitter.start()
                end
            end,
        })
    end,
}
