return {
    'kdheepak/lazygit.nvim',
    cmd = {
        'LazyGit',
        'LazyGitConfig',
        'LazyGitCurrentFile',
        'LazyGitFilter',
        'LazyGitFilterCurrentFile',
    },
    keys = {
        { '<leader>z', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
}
