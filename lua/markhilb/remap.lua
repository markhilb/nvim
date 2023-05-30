-- Keep visual selection when indenting/outdenting
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

vim.keymap.set('n', 'J', '10j')
vim.keymap.set('n', 'K', '10k')

-- Move line up/down
vim.keymap.set('n', '<A-j>', ':m.+1<CR>==', { silent = true })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi', { silent = true })
vim.keymap.set('n', '<A-k>', ':m.-2<CR>==', { silent = true })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi', { silent = true })

-- Tab navigation
vim.keymap.set('n', 't', ':tabn<CR>')
vim.keymap.set('n', 'T', ':tabp<CR>')

-- Execute previous command
vim.keymap.set('n', ';', ':<UP><CR>')

-- Wrap selected text inside
vim.keymap.set('v', '(', 's()<ESC>P')
vim.keymap.set('v', '[', 's[]<ESC>P')
vim.keymap.set('v', '{', 's{}<ESC>P')
vim.keymap.set('v', '"', 's""<ESC>P')
vim.keymap.set('v', "'", "s''<ESC>P")

-- Don't overwrite clipboard on visual paste
vim.keymap.set('v', 'p', '"_dp')
vim.keymap.set('v', 'P', '"_dP')

-- Search for selected text
vim.keymap.set('v', '//', "y/\\V<C-R>=escape(@\",'/\\')<CR><CR>")

-- Don't go to next word when highlighting
vim.keymap.set('n', '*', ':execute "normal! *N"<CR>', { silent = true })
vim.keymap.set('n', '#', ':execute "normal! #N"<CR>', { silent = true })

-- Split resizing
vim.keymap.set('n', '<S-Up>', ':resize +5<CR>', { silent = true })
vim.keymap.set('n', '<S-Down>', ':resize -5<CR>', { silent = true })
vim.keymap.set('n', '<S-Left>', ':vertical resize -5<CR>', { silent = true })
vim.keymap.set('n', '<S-Right>', ':vertical resize +5<CR>', { silent = true })

-- Quickfix list
vim.keymap.set('n', '<C-j>', ':cnext<CR>zz', { silent = true })
vim.keymap.set('n', '<C-k>', ':cprev<CR>zz', { silent = true })

--
-- Leader specific maps
--

vim.g.mapleader = ' '

-- Yank to clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+Y')

-- Delete into black hole register
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d')

-- Quickfix list
vim.keymap.set('n', '<leader>co', ':copen<CR>', { silent = true })
vim.keymap.set('n', '<leader>cc', ':cclose<CR>', { silent = true })

-- Save file
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>W', ':w!<CR>')
vim.keymap.set('n', '<leader>b', ':wa | sus<CR>')

-- Unhighlight search
vim.keymap.set('n', '<leader>l', ':noh<CR>', { silent = true })

-- New tab
vim.keymap.set('n', '<leader>n', ':tabedit<CR>', { silent = true })

-- File explorer
vim.keymap.set('n', '<leader>e', ':tabedit<CR>:Explore<CR>', { silent = true })
vim.keymap.set('n', '<leader>E', ':Explore<CR>', { silent = true })

-- Search previous commands
vim.keymap.set('n', '<leader>r', 'q:?')

-- Swap ' and "
vim.keymap.set('n', "<leader>'", ':%s/"/\'/g<CR>')
vim.keymap.set('n', '<leader>"', ':%s/\'/"/g<CR>')
vim.keymap.set('v', "<leader>'", ':s/"/\'/g<CR>')
vim.keymap.set('v', '<leader>"', ':s/\'/"/g<CR>')

-- Split management
vim.keymap.set('n', '<leader>v', ':vnew<CR>', { silent = true })
vim.keymap.set('n', '<leader>h', ':new<CR>', { silent = true })
vim.keymap.set('n', '<leader><Up>', '<C-w><Up>')
vim.keymap.set('n', '<leader><Down>', '<C-w><Down>')
vim.keymap.set('n', '<leader><Left>', '<C-w><Left>')
vim.keymap.set('n', '<leader><Right>', '<C-w><Right>')
