local function map(mode, left, right, opts)
  local options = {noremap = true}
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, left, right, options)
end

local function nmap(left, right, opts)
  map("n", left, right, opts)
end
local function vmap(left, right, opts)
  map("v", left, right, opts)
end
local function imap(left, right, opts)
  map("i", left, right, opts)
end

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

-- Open/load nvim init
nmap("<Leader>u", ":tabedit ~/.config/nvim<CR>")
nmap("<Leader>U", ":source $MYVIMRC<CR>")

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

-- Formatter
nmap("<Leader>a", ":w | FormatWrite<CR>")

-- Whitespace
nmap("<Leader>f", ":mark q | FixWhitespace<CR>'q:w<CR>")

-- Blamer
nmap("<Leader>B", ":BlamerToggle<CR>", {silent = true})

-- Hop
nmap("r", "<cmd>lua require('hop').hint_char1()<CR>")
vmap("r", "<cmd>lua require('hop').hint_char1()<CR>")

-- FZF
nmap("<Leader>p", "<cmd>lua require('config.fzf').find_files()<CR>")
nmap("<Leader>P", "<cmd>lua require('config.fzf').find_files('.')<CR>")
nmap("<Leader>g", "<cmd>lua require('config.fzf').grep_files()<CR>")
nmap("<Leader>G", "<cmd>lua require('config.fzf').grep_files('.')<CR>")
nmap("<Leader>ti", "<cmd>lua require('config.fzf').find_files('~/.config/nvim')<CR>")
nmap("<Leader>tb", ":Buffers<CR>")
nmap("<Leader>tr", ":History:<CR>")
nmap("<Leader>ts", "History/<CR>")

-- Lsp
nmap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
nmap("gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
nmap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
nmap("gn", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
nmap("gN", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
nmap("gr", "<cmd>lua vim.lsp.buf.rename()<CR>")
nmap("gk", "<cmd>lua vim.lsp.buf.hover()<CR>")
nmap("gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
nmap("<Leader>ca", ":CodeActionMenu<CR>", {silent = true})
nmap("<Leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>")

-- Trouble
nmap("gf", "<cmd>TroubleToggle lsp_references<CR>")
nmap("<Leader>o", "<cmd>TroubleToggle lsp_workspace_diagnostics<CR>")

-- Omnisharp
vim.cmd(
  [[
    augroup omnisharp_commands
      autocmd!

      autocmd CursorHold *.cs OmniSharpTypeLookup

      autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
      autocmd FileType cs nmap <silent> <buffer> gp <Plug>(omnisharp_preview_definition)
      autocmd FileType cs nmap <silent> <buffer> gf <Plug>(omnisharp_find_usages)
      autocmd FileType cs nmap <silent> <buffer> <Leader>opi <Plug>(omnisharp_preview_implementations)
      autocmd FileType cs nmap <silent> <buffer> <Leader>ot <Plug>(omnisharp_type_lookup)
      autocmd FileType cs nmap <silent> <buffer> <Leader>od <Plug>(omnisharp_documentation)
      autocmd FileType cs nmap <silent> <buffer> <Leader>ofs <Plug>(omnisharp_find_symbol)
      autocmd FileType cs nmap <silent> <buffer> <Leader>ou <Plug>(omnisharp_fix_usings)
      autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
      autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

      autocmd FileType cs nmap <silent> <buffer> <Leader>oc <Plug>(omnisharp_global_code_check)
      autocmd FileType cs nmap <silent> <buffer> <Leader>oc <Plug>(omnisharp_global_code_check)

      autocmd FileType cs nmap <silent> <buffer> <Leader>a :OmniSharpCodeFormat\| w<CR>

      autocmd FileType cs nmap <silent> <buffer> <Leader>oa <Plug>(omnisharp_code_actions)
      autocmd FileType cs xmap <silent> <buffer> <Leader>oa <Plug>(omnisharp_code_actions)

      autocmd FileType cs nmap <silent> <buffer> <Leader>o. <Plug>(omnisharp_code_action_repeat)
      autocmd FileType cs xmap <silent> <buffer> <Leader>o. <Plug>(omnisharp_code_action_repeat)

      autocmd FileType cs nmap <silent> <buffer> <Leader>or <Plug>(omnisharp_rename)

      autocmd FileType cs nmap <silent> <buffer> <Leader>osr <Plug>(omnisharp_restart_server)
      autocmd FileType cs nmap <silent> <buffer> <Leader>oss <Plug>(omnisharp_start_server)
      autocmd FileType cs nmap <silent> <buffer> <Leader>osp <Plug>(omnisharp_stop_server)
    augroup END
  ]]
)

-- Treesitter
nmap("<Leader>h", ":TSHighlightCapturesUnderCursor<CR>", {silent = true})
