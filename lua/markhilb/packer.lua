local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

vim.keymap.set('n', '<leader>s', ':PackerSync<CR>')

return require('packer').startup(function(use)
    use('wbthomason/packer.nvim')

    use({ 'norcalli/nvim-colorizer.lua', config = "require('colorizer').setup()" })
    use('tpope/vim-commentary')
    use('windwp/nvim-ts-autotag')
    use({ 'windwp/nvim-autopairs', config = "require('nvim-autopairs').setup({})" })
    use('wellle/targets.vim')
    use('phaazon/hop.nvim')

    use('mhartington/formatter.nvim')

    use('ibhagwan/fzf-lua')

    use({
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        requires = { 'nvim-treesitter/playground' },
    })

    use({
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
            --
            { 'hrsh7th/cmp-nvim-lsp-signature-help' },
            { 'b0o/schemastore.nvim' },
        },
    })

    use({ 'j-hui/fidget.nvim', config = 'require("fidget").setup({})' })

    if packer_bootstrap then
        require('packer').sync()
    end
end)
