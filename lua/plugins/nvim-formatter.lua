return {
    'seblj/nvim-formatter',
    keys = {
        { '<leader>a', function() vim.cmd.Format() end, desc = 'Format buffer' },
    },
    config = function()
        require('formatter').setup({
            filetype = {
                javascript = 'prettierd .js',
                typescript = 'prettierd .ts',
                typescriptreact = 'prettierd .tsx',
                javascriptreact = 'prettierd .jsx',
                html = 'prettierd .html',
                css = 'prettierd .css',
                scss = 'prettierd .scss',
                json = 'prettierd .json',
                markdown = 'prettierd .md',
                yaml = 'prettierd .yaml',
                rust = 'rustfmt --edition=2021',
                lua = 'stylua --search-parent-directories -',
                python = 'autopep8 -',
                c = 'clang-format',
                sql = function()
                    local config = require('config.utils').reverse_find_file('.sql-formatter.json')
                    return {
                        exe = 'sql-formatter',
                        args = config == nil and { '-l', 'postgresql' } or { '--config', config },
                    }
                end,
            },
        })
    end,
}
