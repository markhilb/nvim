local function prettier()
    return {
        exe = 'prettier',
        args = { '--stdin-filepath', vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--stdin' },
    }
end

local filetype = {
    javascript = prettier,
    typescript = prettier,
    typescriptreact = prettier,
    javascriptreact = prettier,
    html = prettier,
    css = prettier,
    scss = prettier,
    json = prettier,
    markdown = prettier,
    rust = 'rustfmt --edition=2021',
    lua = function()
        return {
            exe = 'stylua',
            args = { '--search-parent-directories', '--stdin-filepath', vim.api.nvim_buf_get_name(0), '-' },
        }
    end,
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
