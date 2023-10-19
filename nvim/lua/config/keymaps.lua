local Util = require("util")

Util.map({

    -- ############################################################################
    -- # General
    -- ############################################################################
    { "n", ";", ":", "Command Mode" },
    { "n", "qq", "<CMD> q <CR>", "Quit" },
    { "n", "<leader>ww", "<CMD> w <CR>", "Write File" },
    { "n", "<C-s>", "<CMD> w <CR>", "Write File" },

    { "n", "<leader><leader>", "<CMD> noh <CR>", "Hide search highlights" },
    { "n", "<Esc>", "<CMD> noh <CR>", "Hide search highlights" },

    {
        { "n", "x" },
        "k",
        "v:count == 0 ? 'gk' : 'k'",
        "Up",
        { expr = true },
    },
    {
        { "n", "x" },
        "j",
        "v:count == 0 ? 'gj' : 'j'",
        "Down",
        { expr = true },
    },

    {
        { "n" },
        "<Enter>",
        "a<Enter><Esc>O",
        "Insert Newline",
        { noremap = true },
    },

    { { "i" }, "<M-h>", "<Left>", "Left", { noremap = true } },
    { { "i" }, "<M-j>", "<Down>", "Down", { noremap = true } },
    { { "i" }, "<M-k>", "<Up>", "Up", { noremap = true } },
    { { "i" }, "<M-l>", "<Right>", "Right", { noremap = true } },

    { { "t" }, "<M-h>", "<Left>", "Left", { noremap = true } },
    { { "t" }, "<M-j>", "<Down>", "Down", { noremap = true } },
    { { "t" }, "<M-k>", "<Up>", "Up", { noremap = true } },
    { { "t" }, "<M-l>", "<Right>", "Right", { noremap = true } },

    -- ############################################################################
    -- # Buffers, Windows, and Tabs
    -- ############################################################################

    -- Buffers
    -- Next
    { "n", "<Tab>", "<CMD> bnext <CR>", "Goto next buffer" },
    { "n", "<leader>bn", "<CMD> bnext <CR>", "Goto next (Buffer)" },

    -- Previous
    { "n", "<S-Tab>", "<CMD> bprevious <CR>", "Goto previous buffer" },
    { "n", "<leader>bp", "<CMD> bprevious <CR>", "Goto previous (Buffer)" },

    -- Delete
    { "n", "<leader>x", "<CMD> bdelete <CR>", "Delete current buffer" },
    { "n", "<leader>bx", "<CMD> bdelete <CR>", "Delete (Buffer)" },
    { "n", "<leader>bd", "<CMD> bdelete <CR>", "Delete (Buffer)" },
    { "n", "<leader>db", "<CMD> bdelete <CR>", "Buffer (Delete)" },

    -- Windows
    -- Split
    { "n", "<leader>ws", "<C-w>v", "Split vertically (Window)" },

    -- Balance
    { "n", "<leader>w=", "<C-w>=", "Balance (Window)" },

    -- Goto
    { "n", "<leader>wh", "<C-w>h", "Goto left (Window)" },
    { "n", "<leader>wj", "<C-w>j", "Goto down (Window)" },
    { "n", "<leader>wk", "<C-w>k", "Goto up (Window)" },
    { "n", "<leader>wl", "<C-w>l", "Goto right (Window)" },

    { "n", "<C-h>", "<C-w>h", "Goto left window" },
    { "n", "<C-j>", "<C-w>j", "Goto down window" },
    { "n", "<C-k>", "<C-w>k", "Goto up window" },
    { "n", "<C-l>", "<C-w>l", "Goto right window" },

    -- Move
    { "n", "<leader>wH", "<C-w>H", "Move left (Window)" },
    { "n", "<leader>wJ", "<C-w>J", "Move down (Window)" },
    { "n", "<leader>wK", "<C-w>K", "Move up (Window)" },
    { "n", "<leader>wL", "<C-w>L", "Move right (Window)" },

    -- Delete
    { "n", "<leader>wx", "<C-w>q", "Delete (Window)" },
    { "n", "<leader>dw", "<C-w>q", "Window (Delete)" },

    -- Tabs
    -- Next
    { "n", "<leader>tn", "<CMD> tabnext <CR>", "Goto next (Tab)" },

    -- Previous
    { "n", "<leader>tp", "<CMD> tabprevious <CR>", "Goto previous (Tab)" },

    -- Delete
    { "n", "<leader>tx", "<CMD> tabclose <CR>", "Delete (Tab)" },
    { "n", "<leader>dt", "<CMD> tabclose <CR>", "Tab (Delete)" },

    -- ############################################################################
    -- # Lazy
    -- ############################################################################
    { "n", "<leader>ol", "<CMD> Lazy <CR>", "Lazy" },
})
