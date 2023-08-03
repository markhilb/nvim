local flash = require('flash')

flash.setup({
    highlight = {
        matches = false,
    },
    modes = {
        search = {
            enabled = false,
        },
        char = {
            enabled = false,
        },
    },
})

vim.keymap.set({ 'n', 'x' }, 'r', flash.jump)
vim.keymap.set({ 'o' }, 'r', flash.remote)
vim.keymap.set({ 'n', 'x', 'o' }, 'R', flash.treesitter_search)
