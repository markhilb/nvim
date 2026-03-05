return {
    'stevearc/conform.nvim',
    opts = {
        formatters_by_ft = {
            javascript = { 'prettier' },
            typescript = { 'prettier' },
            typescriptreact = { 'prettier' },
            javascriptreact = { 'prettier' },
            html = { 'prettier' },
            css = { 'prettier' },
            scss = { 'prettier' },
            json = { 'prettier' },
            markdown = { 'prettier' },
            yaml = { 'prettier' },
            sql = { 'sql_formatter_dynamic' },
            ['*'] = { 'injected'},
            ['_'] = { 'injected', lsp_format = "first" },
        },

        formatters = {
            prettier = {
                command = 'prettier',
                args = { '--stdin-filepath', '$FILENAME' },
                stdin = true,
            },

            sql_formatter_dynamic = {
                command = 'sql-formatter',
                args = function(ctx)
                    local config = vim.fs.find('.sql-formatter.json', {
                        upward = true,
                        path = ctx.dirname,
                    })[1]

                    return config and { '--config', config } or { '-l', 'postgresql' }
                end,
                stdin = true,
            },
        },
    },
    keys = {
        {
            '<leader>a',
            function()
                require('conform').format({ async = true, }, function() vim.cmd('w') end)
            end,
        },
    },
}
