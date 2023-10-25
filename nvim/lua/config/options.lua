vim.g.mapleader = " "
vim.g.maplocalleader = "//"

vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

vim.g.autoformat = true

local opt = vim.opt

-- #############################################################################
-- # GUI
-- #############################################################################

-- Update frequency
opt.updatetime = 100

-- Colors
opt.termguicolors = true -- Full color support
opt.background = "dark" -- Colorscheme background

-- Syntax and Filetype
opt.syntax = "on" -- Syntax highlighting
opt.filetype = "on" -- Filetype detection

-- Font
opt.guifont = "JetBrainsMono Nerd Font Mono:h14"

-- Line numbers
opt.number = true -- Line numbers
opt.relativenumber = true -- Relative line numbers

-- Columns and Cursorline
opt.numberwidth = 1
opt.signcolumn = "yes"
opt.colorcolumn = "80"
opt.cursorline = true

-- Statusline and Cmdline
opt.laststatus = 3 -- Statusline
opt.showcmd = false
opt.cmdheight = 0
opt.ruler = false
opt.showmode = false

-- Lists
opt.list = true
opt.listchars = {
    tab = " ",

    lead = "·",
    trail = "·",

    extends = "»",
    precedes = "«",

    nbsp = "×",
}
opt.fillchars = {
    fold = "⸱",
    foldopen = "",
    foldclose = "",
    foldsep = " ",
    diff = "╱",
    eob = " ",

    -- Window border chars
    vert = " ",
    vertleft = " ",
    vertright = " ",
    horiz = " ",
    horizup = " ",
    horizdown = " ",
    verthoriz = " ",
}

-- Windows and Splitting
opt.winminwidth = 1
opt.winminheight = 1
opt.winblend = 10
opt.splitkeep = "screen"
opt.splitright = true
opt.splitbelow = true

-- Popups
opt.pumblend = 15
opt.pumheight = 10

-- Cursor
opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver20,r-cr-o:hor20"

-- #############################################################################
-- # Editor
-- #############################################################################

-- Indentation
opt.autoindent = true
opt.smartindent = true
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.shiftround = true

-- Line wrapping
opt.wrap = true
opt.linebreak = true
opt.breakindent = true
opt.breakindentopt = "shift:4"
opt.textwidth = 80

-- Searching
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Wildmenu
opt.wildmenu = false
opt.wildmode = "longest:full,full"
opt.wildignore = opt.wildignore
    + {
        "*/node_modules/*",
        "*/.git/*",
        "*/vendor/*",
        "*DS_STORE",
    }

-- Completion
opt.completeopt = "menuone,noinsert,noselect"
opt.infercase = true

-- Virtual editing
opt.virtualedit = "block"

-- Scrolling
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.smoothscroll = true

-- Folding and conceal
opt.foldenable = false
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldcolumn = "auto"
opt.conceallevel = 2
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Confirm unsaved changes
opt.confirm = true

-- Formatting
opt.formatoptions = "jcroqlnt"

-- Grep
opt.grepprg = "rg --vimgrep"
opt.grepformat = "%f:%l:%c:%m"

-- #############################################################################
-- # Other
-- #############################################################################

-- Key Timeout
opt.timeout = true
opt.timeoutlen = 300

-- Mouse support
opt.mouse = "a"

-- Set window title
opt.title = true

-- Clipboard
opt.clipboard = "unnamedplus"

-- Backup and Swap
opt.swapfile = false
opt.backup = false
opt.writebackup = false

-- Undo
opt.undofile = true
opt.undolevels = 10000
opt.undodir = { os.getenv("HOME") .. "/.vim/undodir" }

-- Cmdline history
opt.history = 1000

-- Encoding
opt.encoding = "utf-8"

-- Spelling
opt.spelllang = { "en" }

-- Sessions
opt.sessionoptions = {
    "buffers",
    "curdir",
    "tabpages",
    "winsize",
    "help",
    "globals",
    "skiprtp",
}

-- Preview incremental substitute
opt.inccommand = "nosplit"

opt.isfname:append("@-@")
opt.shortmess:append({
    W = true,
    I = true,
    c = true,
    C = true,
})

opt.shellcmdflag = "-ic"

-- Disable globals
vim.g.loaded_netrw = 1
vim.g.loaded_perl_provider = 0

vim.g.markdown_recommended_style = 0

if vim.fn.exists("syntax_on") ~= 1 then
    vim.cmd("syntax on")
end

vim.cmd("filetype plugin indent on")

-- Neovide Configuration
if vim.g.neovide then
    -- General
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_theme = "dark"
    vim.g.neovide_refresh_rate = 60
    vim.g.neovide_refresh_rate_idle = 5

    -- Cursor
    vim.g.neovide_cursor_animation_length = 0.10
    vim.g.neovide_cursor_trail_size = 0.2
    vim.g.neovide_cursor_antialiasing = true
    vim.g.neovide_cursor_animate_in_insert_mode = true
    vim.g.neovide_cursor_animate_command_line = true
end
