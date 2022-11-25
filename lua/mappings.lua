local utils = require("utils")
local nmap, vmap, imap = utils.nmap, utils.vmap, utils.imap

-- Keep selection when indenting/outdenting
vmap(">", ">gv")
vmap("<", "<gv")

nmap("J", "10j")
nmap("K", "10k")

-- Move line up/down
nmap("<A-j>", ":m.+1<CR>==", {silent = true})
vmap("<A-j>", ":m '>+1<CR>gv=gv", {silent = true})
imap("<A-j>", "<Esc>:m .+1<CR>==gi", {silent = true})
nmap("<A-k>", ":m.-2<CR>==", {silent = true})
vmap("<A-k>", ":m '<-2<CR>gv=gv", {silent = true})
imap("<A-k>", "<Esc>:m .-2<CR>==gi", {silent = true})

-- Tab navigation
nmap("t", ":tabn<CR>")
nmap("T", ":tabp<CR>")

-- Execute previous command
nmap(";", ":<UP><CR>")

-- Wrap selected text inside
vmap("(", "s()<ESC>P")
vmap("[", "s[]<ESC>P")
vmap("{", "s{}<ESC>P")
vmap('"', 's""<ESC>P')
vmap("'", "s''<ESC>P")

-- Don't overwrite clipboard on visual paste
vmap("p", '"_dp')
vmap("P", '"_dP')

-- Search for selected text
vmap("//", 'y/\\V<C-R>=escape(@",\'/\\\')<CR><CR>')

-- Don't go to next word when highlighting
nmap("*", ':execute "normal! *N"<CR>', {silent = true})
nmap("#", ':execute "normal! #N"<CR>', {silent = true})

-- Yank to end of line
nmap("Y", "y$")

-- Split resizing
nmap("<S-Up>", ":resize +5<CR>", {silent = true})
nmap("<S-Down>", ":resize -5<CR>", {silent = true})
nmap("<S-Left>", ":vertical resize -5<CR>", {silent = true})
nmap("<S-Right>", ":vertical resize +5<CR>", {silent = true})

--
-- Leader specific maps
--

vim.g.mapleader = " "

-- Save file
nmap("<Leader>w", ":w<CR>")
nmap("<Leader>W", ":w!<CR>")
nmap("<Leader>b", ":wa | sus<CR>")

-- Quickfix list
nmap("<Leader>co", ":copen<CR>")
nmap("<Leader>cO", ":cclose<CR>")
nmap("<Leader>CO", ":cclose<CR>")

-- Unhighlight search
nmap("<Leader>l", ":noh<CR>", {silent = true})

-- Tab management
nmap("<Leader>n", ":tabedit<CR>", {silent = true})

-- File explorer
nmap("<Leader>e", ":tabedit<CR>:Explore<CR>", {silent = true})
nmap("<Leader>E", ":Explore<CR>", {silent = true})

-- Search previous commands
nmap("<Leader>r", "q:?")

-- Swap ' and "
nmap("<Leader>'", ':%s/"/\'/g<CR>')
nmap('<Leader>"', ':%s/\'/"/g<CR>')

-- Split management
nmap("<Leader>v", ":vnew<CR>", {silent = true})
nmap("<Leader>h", ":new<CR>", {silent = true})
nmap("<Leader><Up>", "<C-w><Up>")
nmap("<Leader><Down>", "<C-w><Down>")
nmap("<Leader><Left>", "<C-w><Left>")
nmap("<Leader><Right>", "<C-w><Right>")

-- Yank entire file
nmap("<Leader>y", "ggyG")

--
-- Plugin maps
--

-- Packer
nmap("<Leader>s", ":PackerSync<CR>")

-- Formatter
nmap("<Leader>a", "<cmd>lua require('config/formatter').format()<CR>")
vmap("<Leader>a", "<cmd>lua require('config/formatter').format(true)<CR>")
vmap("<Leader>s", "<cmd>lua require('config/formatter').format(true, 'sql')<CR>")

-- Whitespace
nmap("<Leader>f", ":mark q | FixWhitespace<CR>'q:w<CR>")

-- Blamer
nmap("<Leader>B", ":BlamerToggle<CR>", {silent = true})

-- Hop
nmap("r", "<cmd>lua require('hop').hint_char1()<CR>")
vmap("r", "<cmd>lua require('hop').hint_char1()<CR>")

-- FZF
nmap("<Leader>p", "<cmd>lua require('fzf-lua').files({ cwd = require('utils').git_root() })<CR>")
nmap("<Leader>P", "<cmd>lua require('fzf-lua').files()<CR>")
nmap("<Leader>g", "<cmd>lua require('fzf-lua').grep_project({ cwd = require('utils').git_root() })<CR>")
nmap("<Leader>G", "<cmd>lua require('fzf-lua').grep_project()<CR>")
nmap("<Leader>tt", "<cmd>lua require('fzf-lua').builtin()<CR>")
nmap("<Leader>ti", "<cmd>lua require('config/fzf').find_files('~/.config/nvim')<CR>")
nmap("<Leader>tb", "<cmd>lua require('fzf-lua').buffers()<CR>")
nmap("<Leader>tr", "<cmd>lua require('fzf-lua').command_history()<CR>")
nmap("<Leader>ts", "<cmd>lua require('fzf-lua').search_history()<CR>")
nmap("<Leader>tc", "<cmd>lua require('fzf-lua').git_commits()<CR>")

-- Lsp
nmap("gd", "<cmd>lua require('fzf-lua').lsp_definitions()<CR>")
nmap("gt", "<cmd>lua require('fzf-lua').lsp_typedefs()<CR>")
nmap("gi", "<cmd>lua require('fzf-lua').lsp_implementations()<CR>")
nmap("gn", "<cmd>lua vim.diagnostic.goto_next()<CR>")
nmap("gN", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
nmap("gr", "<cmd>lua vim.lsp.buf.rename()<CR>")
nmap("gk", "<cmd>lua vim.lsp.buf.hover()<CR>")
nmap("gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
nmap("gf", "<cmd>lua require('fzf-lua').lsp_references()<CR>")
nmap("<Leader>i", "<cmd>lua vim.lsp.buf.formatting()<CR>")
nmap("<Leader>ca", "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>")
nmap("<Leader>o", "<cmd>lua require('fzf-lua').lsp_document_diagnostics()<CR>")
nmap("<Leader>O", "<cmd>lua require('fzf-lua').lsp_workspace_diagnostics()<CR>")

-- Treesitter
nmap("<Leader>H", ":TSHighlightCapturesUnderCursor<CR>", {silent = true})
