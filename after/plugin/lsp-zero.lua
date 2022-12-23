local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.ensure_installed({
    'tsserver',
    'eslint',
    'angularls',
    'sumneko_lua',
    'rust_analyzer',
    'taplo',
    'omnisharp',
    'yamlls',
    'jsonls',
    'dockerls',
})

lsp.configure('angularls', { filetypes = { 'html' } })

lsp.configure('rust_analyzer', {
    settings = {
        ['rust-analyzer'] = {
            cargo = {
                allFeatures = true,
                allTargets = true,
            },
            checkOnSave = {
                command = 'clippy',
                allFeatures = true,
                allTargets = true,
            },
        },
    },
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
lsp.setup_nvim_cmp({
    mapping = lsp.defaults.cmp_mappings({
        ['<Enter>'] = nil,
        ['<Tab>'] = nil,
        ['<S-Tab>'] = nil,
        ['<Up>'] = nil,
        ['<Down>'] = nil,
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'luasnip' },
        { name = 'calc' },
        { name = 'nvim_lsp_signature_help' },
    },
})

lsp.set_preferences({
    set_lsp_keymaps = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I',
    },
})

lsp.on_attach(function(_, bufnr)
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
end)

lsp.setup()
