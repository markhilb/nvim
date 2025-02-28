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
    rust = 'rustfmt --edition=2024',
    lua = 'stylua --search-parent-directories -',
    c = 'clang-format',
    sql = function()
        local config = require('config.utils').reverse_find_file('.sql-formatter.json')
        return {
            exe = 'sql-formatter',
            args = config == nil and { '-l', 'postgresql' } or { '--config', config },
        }
    end,
}

return {
    'seblyng/nvim-formatter',
    keys = {
        {
            '<leader>a',
            function()
                if filetype[vim.bo.filetype] == nil then
                    vim.lsp.buf.format()
                    vim.cmd('w')
                else
                    vim.cmd('w')
                    vim.cmd.Format()
                end
            end,
            desc = 'Format buffer',
        },
    },
    config = function()
        require('formatter').setup({
            filetype = filetype,
        })
    end,
}
