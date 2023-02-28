vim.cmd([[
    syntax on
]])

vim.cmd([[
    filetype plugin indent on
]])

vim.o.background = 'dark'

-- Line Numbers
vim.opt.nu = true
vim.opt.rnu = true --relative line numbers

-- Indentation
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

-- Search
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

vim.opt.wildmenu = true
vim.opt.wildignore = vim.opt.wildignore + { '*/node_modules/*', '*/.git/*', '*/vendor/*' }

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '80'

vim.opt.isfname:append '@-@'

vim.opt.updatetime = 100

vim.opt.encoding = 'utf-8'

vim.opt.cursorline = true
vim.opt.laststatus = 2

vim.opt.list = true
vim.opt.listchars = {
    tab = '❘-',
    trail = '·',
    lead = '·',
    extends = '»',
    precedes = '«',
    nbsp = '×',
}

vim.opt.termguicolors = true

-- Netrw
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
