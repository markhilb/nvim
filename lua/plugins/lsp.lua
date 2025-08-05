local function lsp_attach(event)
    local bufnr = event.buf

    local id = vim.tbl_get(event, 'data', 'client_id')
    if id == nil then
        return
    end

    local client = vim.lsp.get_client_by_id(id)

    -- Disable lsp semantic highlighting
    if client.server_capabilities ~= nil then
        client.server_capabilities.semanticTokensProvider = {}
    end

    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set('n', 'gd', function() require('fzf-lua').lsp_definitions() end, opts)
    vim.keymap.set('n', 'gt', function() require('fzf-lua').lsp_typedefs() end, opts)
    vim.keymap.set('n', 'gi', function() require('fzf-lua').lsp_implementations() end, opts)
    vim.keymap.set('n', 'gf', function() require('fzf-lua').lsp_references() end, opts)
    vim.keymap.set('n', 'gn', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', 'gN', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', 'gk', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>i', vim.lsp.buf.format, opts)
    vim.keymap.set('n', '<leader>ca', function() require('fzf-lua').lsp_code_actions() end, opts)
    vim.keymap.set('n', '<leader>o', function() require('fzf-lua').lsp_document_diagnostics() end, opts)
    vim.keymap.set('n', '<leader>O', function() require('fzf-lua').lsp_workspace_diagnostics() end, opts)
end

local group = vim.api.nvim_create_augroup('LspAttachGroup', { clear = true })
vim.api.nvim_create_autocmd('LspAttach', {
    group = group,
    desc = 'lsp on_attach',
    callback = lsp_attach,
})

return {
    {
        'mason-org/mason-lspconfig.nvim',
        dependencies = {
            'neovim/nvim-lspconfig',
            'b0o/schemastore.nvim',
            { 'mason-org/mason.nvim', opts = {} },
            --
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'L3MON4D3/LuaSnip',
            'rafamadriz/friendly-snippets',
            'hrsh7th/cmp-nvim-lsp-signature-help',
        },
        config = function()
            local util = require('lspconfig.util')
            local defaults = util.default_config.capabilities or {}
            util.default_config.capabilities =
                vim.tbl_deep_extend('force', defaults, require('cmp_nvim_lsp').default_capabilities())

            vim.lsp.config('angularls', { filetypes = { 'html' } })
            vim.lsp.config('jsonls', {
                settings = {
                    json = {
                        schemas = require('schemastore').json.schemas(),
                        validate = { enable = true },
                    },
                },
            })
            vim.lsp.config('yamlls', {
                settings = {
                    yaml = {
                        keyOrdering = false,
                    },
                },
            })

            require('mason-lspconfig').setup({
                ensure_installed = {
                    'ts_ls',
                    'eslint',
                    'angularls',
                    'cssls',
                    'lua_ls',
                    'rust_analyzer',
                    'taplo',
                    'omnisharp',
                    'yamlls',
                    'jsonls',
                    'dockerls',
                },
                automatic_enable = {
                    exclude = { 'rust_analyzer' },
                },
            })

            local cmp = require('cmp')
            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                preselect = cmp.PreselectMode.Item,
                completion = {
                    completeopt = 'menu,menuone,noinsert',
                },
                mapping = cmp.mapping.preset.insert({
                    ['<Tab>'] = nil,
                    ['<S-Tab>'] = nil,
                    ['<Up>'] = nil,
                    ['<Down>'] = nil,
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-Space>'] = cmp.mapping.complete(),
                }),
                snippet = {
                    expand = function(args) require('luasnip').lsp_expand(args.body) end,
                },
                formatting = {
                    format = function(_, vim_item)
                        if vim.bo.filetype == 'rust' and vim_item.menu ~= nil then
                            -- `menu` items in rust are structured like this: " (use tokio::sync::broadcast::channel)fn(usize) -> (Sender<T>, Receiver<T>)"
                            -- this is too long, so shorten it to just "tokio::sync::broadcast::channel"

                            local namespace = string.match(vim_item.menu, '%s*%(use ([^%)]*)%).*')
                            if namespace ~= nil then
                                vim_item.menu = namespace
                            end
                        end
                        return vim_item
                    end,
                },
                sources = {
                    { name = 'path' },
                    { name = 'nvim_lsp' },
                    { name = 'buffer' },
                    { name = 'luasnip' },
                    { name = 'calc' },
                    { name = 'nvim_lsp_signature_help' },
                },
            })
        end,
    },
}
