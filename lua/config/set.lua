vim.cmd.colorscheme('colorscheme')

vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'auto'
vim.opt.scrolloff = 8
vim.opt.termguicolors = true
vim.opt.lazyredraw = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv('HOME') .. '/.cache/nvim/undo'

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.g.netrw_keepdir = 0
