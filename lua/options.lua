local opt = vim.opt

vim.cmd("colorscheme colorscheme")

opt.clipboard = "unnamedplus"
opt.mouse = "a"
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.scrolloff = 8
opt.termguicolors = true

-- Indentation
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

-- Swap/undo
opt.swapfile = false
opt.undofile = true
opt.undodir = os.getenv("HOME").."/.cache/nvim/undo"
opt.undolevels = 1000
opt.undoreload = 10000

-- Window split
opt.splitbelow = true
opt.splitright = true

-- Explore (netrw)
vim.g.netrw_keepdir = 0
