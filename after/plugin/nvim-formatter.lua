local filetype = {
    javascript = 'prettier --stdin-filepath .js',
    typescript = 'prettier --stdin-filepath .ts',
    typescriptreact = 'prettier --stdin-filepath .tsx',
    javascriptreact = 'prettier --stdin-filepath .jsx',
    html = 'prettier --stdin-filepath .html',
    css = 'prettier --stdin-filepath .css',
    scss = 'prettier --stdin-filepath .scss',
    json = 'prettier --stdin-filepath .json',
    markdown = 'prettier --stdin-filepath .md',
    rust = 'rustfmt --edition=2021',
    lua = 'stylua --search-parent-directories -',
    sql = function()
        local config = require('markhilb.utils').reverse_find_file('.sql-formatter.json')
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
