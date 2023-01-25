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
    lua = function()
        return {
            exe = 'stylua',
            args = { '--search-parent-directories', '--stdin-filepath', vim.api.nvim_buf_get_name(0), '-' },
        }
    end,
    rust = function()
        return {
            exe = 'rustfmt',
            args = { '--emit=stdout' },
        }
    end,
    sql = function()
        local config = require('markhilb.utils').reverse_find_file('.sql-formatter.json')
        return {
            exe = 'sql-formatter',
            args = config == nil and {} or { '--config', config },
        }
    end,
}

require('formatter').setup({ filetype = filetype })

local function format()
    if vim.bo.filetype == '' then
        vim.cmd('w')
    elseif filetype[vim.bo.filetype] == nil then
        vim.lsp.buf.formatting_sync()
        vim.cmd('FormatInjections | w')
    else
        vim.cmd('Format | w')
    end
end

vim.keymap.set('n', '<leader>a', format)
