return {
    lazy = false,
    'stevearc/oil.nvim',
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    keys = {
        { '<leader>e', vim.cmd.Oil, desc = 'Open parent directory' },
    },
    opts = {
        view_options = {
            show_hidden = true,
        },
    },
}
