local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

require('nvim-treesitter.configs').setup({
    ensure_installed = 'all',
    highlight = { enable = true },
    autotag = { enable = true },
})

autocmd('FileType', {
    pattern = 'rust',
    group = augroup('RustOverrideQuery', { clear = true }),
    callback = function() require('markhilb.utils').override_queries('rust', 'injections') end,
    desc = 'Override rust treesitter injection',
})

vim.keymap.set('n', '<leader>H', ':TSHighlightCapturesUnderCursor<CR>', { silent = true })
