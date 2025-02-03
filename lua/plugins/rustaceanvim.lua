return {
    'mrcjkb/rustaceanvim',
    version = '^5',
    lazy = false,
    dependencies = {
        {
            'mfussenegger/nvim-dap',
            keys = {
                { '<leader>d', '', desc = '+debug', mode = { 'n', 'v' } },
                {
                    '<leader>db',
                    function() require('dap').toggle_breakpoint() end,
                    desc = 'Toggle Breakpoint',
                },
                {
                    '<leader>dB',
                    function() require('dap').clear_breakpoints() end,
                    desc = 'Clear Breakpoints',
                },
                {
                    '<leader>dc',
                    function() require('dap').continue() end,
                    desc = 'Continue',
                },
                {
                    '<leader>dC',
                    function() require('dap').run_to_cursor() end,
                    desc = 'Run to Cursor',
                },
                {
                    '<leader>dl',
                    function() require('dap').run_last() end,
                    desc = 'Run Last',
                },
                {
                    '<leader>ds',
                    function() require('dap').step_into() end,
                    desc = 'Step Into',
                },
                {
                    '<leader>dS',
                    function() require('dap').step_out() end,
                    desc = 'Step Out',
                },
                {
                    '<leader>dn',
                    function() require('dap').step_over() end,
                    desc = 'Step Over',
                },
                {
                    '<leader>dt',
                    function() require('dap').terminate() end,
                    desc = 'Terminate',
                },
                {
                    '<leader>dk',
                    function() require('dap.ui.widgets').hover() end,
                    desc = 'Hover',
                },
            },
        },
        {
            'rcarriga/nvim-dap-ui',
            dependencies = { 'nvim-neotest/nvim-nio' },
            keys = {
                {
                    '<leader>du',
                    function() require('dapui').toggle({}) end,
                    desc = 'Dap UI',
                },
            },
            opts = {},
            config = function(_, opts)
                local dap = require('dap')
                local dapui = require('dapui')
                dapui.setup(vim.tbl_deep_extend('force', opts, {
                    controls = {
                        enabled = false,
                    },
                    layouts = {
                        {
                            elements = {
                                { id = 'scopes', size = 1 / 3 },
                                { id = 'breakpoints', size = 1 / 3 },
                                { id = 'stacks', size = 1 / 3 },
                            },
                            position = 'left',
                            size = 60,
                        },
                        {
                            elements = {
                                { id = 'repl', size = 1 / 2 },
                                { id = 'console', size = 1 / 2 },
                            },
                            position = 'bottom',
                            size = 20,
                        },
                    },
                }))
                dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open({}) end
                dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close({}) end
                dap.listeners.before.event_exited['dapui_config'] = function() dapui.close({}) end
            end,
        },
    },
    keys = {
        -- Debugger
        {
            '<leader>dD',
            function() vim.cmd.RustLsp('debug') end,
            desc = 'Run RustLsp debug',
        },
        {
            '<leader>DD',
            function() vim.cmd.RustLsp({ 'debug', bang = true }) end,
            desc = 'Run RustLsp! debug',
        },
        {
            '<leader>dd',
            function() vim.cmd.RustLsp('debuggables') end,
            desc = 'Run RustLsp debugger',
        },
        {
            '<leader>Dd',
            function() vim.cmd.RustLsp({ 'debuggables', bang = true }) end,
            desc = 'Run RustLsp! debugger',
        },

        -- Other
        {
            '<leader>rc',
            function() vim.cmd.RustLsp('openCargo') end,
            desc = 'Open Cargo.toml',
        },
        {
            '<leader>rd',
            function() vim.cmd.RustLsp('openDocs') end,
            desc = 'Open docs.rs',
        },
        {
            '<leader>rp',
            function() vim.cmd.RustLsp('parentModule') end,
            desc = 'Open Parent Module',
        },
    },
    config = function()
        vim.g.rustaceanvim = {
            server = {
                default_settings = {
                    ['rust-analyzer'] = {
                        cargo = {
                            allFeatures = true,
                            allTargets = true,
                            targetDir = '/home/markus/.cargo/target/rust-analyzer',
                            extraEnv = {
                                CARGO_TARGET_DIR = '/home/markus/.cargo/target/rust-analyzer',
                            },
                        },
                        check = {
                            command = 'clippy',
                            allFeatures = true,
                            allTargets = true,
                        },
                        diagnostics = {
                            refreshSupport = false,
                            disabled = {
                                'needless_return',
                            },
                        },
                    },
                },
            },
        }
    end,
}
