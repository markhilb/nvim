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

vim.keymap.set({ 'n', 'x' }, 'r', function()
    flash.jump({ search = { mode = function(str) return '\\<' .. str end } })
end)
vim.keymap.set({ 'o' }, 'r', flash.remote)
vim.keymap.set({ 'n', 'x', 'o' }, 'R', flash.treesitter_search)
