return {
    'seblj/nvim-formatter',
    config = function()
        local filetype = {
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
        }

        require('formatter').setup({ filetype = filetype })

        local function format()
            vim.cmd('w')

            if filetype[vim.bo.filetype] == nil then
                vim.lsp.buf.format()
                vim.cmd('w')
                vim.cmd.FormatWrite('injections')
            else
                vim.cmd.FormatWrite()
            end
        end

        vim.keymap.set('n', '<leader>a', format)
    end,
}
