return {
    'ibhagwan/fzf-lua',
    config = function()
        local fzf_lua = require('fzf-lua')

        fzf_lua.setup({
            fzf_opts = {
                ['--layout'] = 'default',
            },
            keymap = {
                builtin = {
                    ['<C-d>'] = 'preview-page-down',
                    ['<C-u>'] = 'preview-page-up',
                },
                fzf = {
                    ['ctrl-a'] = 'toggle-all',
                },
            },
            grep = {
                rg_opts = '--hidden --column --line-number --no-heading --color=always --smart-case --max-columns=512',
            },
        })

        vim.keymap.set('n', '<leader>p', function() fzf_lua.files({ cwd = require('config.utils').git_root() }) end)
        vim.keymap.set('n', '<leader>P', fzf_lua.files)
        vim.keymap.set(
            'n',
            '<leader>g',
            function() fzf_lua.live_grep_native({ cwd = require('config.utils').git_root() }) end
        )
        vim.keymap.set('n', '<leader>G', fzf_lua.live_grep_native)
        vim.keymap.set('n', '<leader>tt', fzf_lua.builtin)
        vim.keymap.set('n', '<leader>ti', function() fzf_lua.files({ cwd = '~/.config/nvim' }) end)
        vim.keymap.set('n', '<leader>td', function() fzf_lua.files({ cwd = '~/dotfiles' }) end)
        vim.keymap.set('n', '<leader>tb', fzf_lua.buffers)
        vim.keymap.set('n', '<leader>tr', fzf_lua.command_history)
        vim.keymap.set('n', '<leader>ts', fzf_lua.lsp_document_symbols)
        vim.keymap.set('n', '<leader>tS', fzf_lua.lsp_workspace_symbols)
        vim.keymap.set('n', '<leader>tc', fzf_lua.git_commits)
    end,
}
