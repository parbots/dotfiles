local Util = require("util")

local opts = {
    noremap = true,
    silent = false,
}

Util.map({
    -- #########################################################################
    -- # General
    -- #########################################################################

    -- Unmap space
    { { "" }, "<space>", "<nop>", "Leader" },

    -- Easier command mode
    { { "n" }, ";", ":", "Command Mode" },

    -- Easier execute external
    { { "n" }, "!", ":!", "Execute External Command" },

    -- Easier quitting
    { { "n" }, "Q", "<cmd> q <cr>", "Quit" },
    { { "n" }, "qq", "<cmd> q <cr>", "Quit" },

    -- Easier writing
    { { "n" }, "<leader>ww", "<cmd> w <cr>", "Write File" },
    { { "n" }, "<C-s>", "<cmd> w <cr>", "Write File" },

    -- #########################################################################
    -- # Movement
    -- #########################################################################

    -- Move cursor based on physical lines, not the actual lines
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

    -- Move cursor in insert mode and terminal mode
    { { "i", "t" }, "<M-h>", "<left>", "Left" },
    { { "i", "t" }, "<M-j>", "<down>", "Down" },
    { { "i", "t" }, "<M-k>", "<up>", "Up" },
    { { "i", "t" }, "<M-l>", "<right>", "Right" },

    -- Goto beginning and end of line in insert and command mode
    { { "i", "c" }, "<C-a>", "<home>", "Goto Start (Line)" },
    { { "i", "c" }, "<C-e>", "<end>", "Goto End (Line)" },

    -- Center the screen when jumping up and down
    { { "n" }, "<C-u>", "<C-u>zz", "Scroll Up" },
    { { "n" }, "<C-d>", "<C-d>zz", "Scroll Down" },

    -- #########################################################################
    -- # Searching
    -- #########################################################################

    -- Center Search
    { { "n" }, "n", "nzz", "Next (Search)" },
    { { "n" }, "N", "Nzz", "Previous (Search)" },

    -- Hide Search
    { { "n" }, "<esc>", "<cmd> noh <cr>", "Hide (Search)" },
    { { "n" }, "\\", "<cmd> noh <cr>", "Hide (Search)" },

    -- #########################################################################
    -- # Editing
    -- #########################################################################

    -- Change text without putting it into the vim register
    { { "n" }, "c", '"_c', "+change" },
    { { "n" }, "C", '"_C', "Change to End (Line)" },
    { { "n" }, "cc", '"_cc', "Change (Line)" },
    { { "x" }, "c", '"_c', "+change" },

    -- Do not move cursor when joining lines
    {
        { "n" },
        "J",
        function()
            vim.cmd([[
        normal! mzJ`z
        delmarks z
        ]])
        end,
        "Join Line",
    },
    {
        { "n" },
        "gJ",
        function()
            vim.cmd([[
        normal! zmgJ`z
        delmarks z
        ]])
        end,
        "Join Visual Lines",
    },

    -- #########################################################################
    -- # Buffers
    -- #########################################################################

    -- Goto Next and Previous
    { { "n" }, "<tab>", "<cmd> bnext <cr>", "Goto Next (Buffer)" },
    { { "n" }, "<s-tab>", "<cmd> bprevious <cr>", "Goto Previous (Buffer)" },

    { { "n" }, "<leader>bn", "<cmd> bnext <cr>", "Goto Next (Buffer)" },
    { { "n" }, "<leader>bp", "<cmd> bprevious <cr>", "Goto Previous (Buffer)" },

    { { "n" }, "H", "<cmd> bnext <cr>", "Goto Next (Buffer)" },
    { { "n" }, "L", "<cmd> bprevious <cr>", "Goto Previous (Buffer)" },

    -- Delete
    { { "n" }, "<leader>x", "<cmd> bdelete <cr>", "Delete Current (Buffer)" },
    { { "n" }, "<leader>bx", "<cmd> bdelete <cr>", "Delete (Buffer)" },
    { { "n" }, "<leader>bd", "<cmd> bdelete <cr>", "Delete (Buffer)" },
    { { "n" }, "<leader>db", "<cmd> bdelete <cr>", "Buffer (Delete)" },

    -- #########################################################################
    -- # Windows
    -- #########################################################################

    -- Splits
    { { "n" }, "<leader>ws", "<C-w>v", "Split Vertically (Window)" },

    -- Balance
    { { "n" }, "<leader>w=", "<C-w>=", "Balance (Window)" },

    -- Goto
    { { "n" }, "<leader>wh", "<C-w>h", "Goto Left (Window)" },
    { { "n" }, "<leader>wj", "<C-w>j", "Goto Down (Window)" },
    { { "n" }, "<leader>wk", "<C-w>k", "Goto Up (Window)" },
    { { "n" }, "<leader>wl", "<C-w>l", "Goto Right (Window)" },
    { { "n" }, "<C-h>", "<C-w>h", "Goto Left (Window)" },
    { { "n" }, "<C-j>", "<C-w>j", "Goto Down (Window)" },
    { { "n" }, "<C-k>", "<C-w>k", "Goto Up (Window)" },
    { { "n" }, "<C-l>", "<C-w>l", "Goto Right (Window)" },

    -- Move
    { { "n" }, "<leader>wH", "<C-w>H", "Move Left (Window)" },
    { { "n" }, "<leader>wJ", "<C-w>J", "Move Down (Window)" },
    { { "n" }, "<leader>wK", "<C-w>K", "Move Up (Window)" },
    { { "n" }, "<leader>wL", "<C-w>L", "Move Right (Window)" },

    -- Delete
    { { "n" }, "<leader>wx", "<C-w>q", "Delete (Window)" },
    { { "n" }, "<leader>dw", "<C-w>q", "Window (Delete)" },

    -- #########################################################################
    -- # Tabs
    -- #########################################################################

    -- Goto Next and Previous
    { { "n" }, "<leader>tn", "<cmd> tabnext <cr>", "Goto Next (Tab)" },
    { { "n" }, "<leader>tp", "<cmd> tabprevious <cr>", "Goto Previous (Tab)" },

    -- Delete
    { { "n" }, "<leader>tx", "<cmd> tabclose <cr>", "Delete (Tab)" },
    { { "n" }, "<leader>dt", "<cmd> tabclose <cr>", "Tab (Delete)" },

    -- #########################################################################
    -- # Lazy
    -- #########################################################################
    { { "n" }, "<leader>ol", "<cmd> Lazy <cr>", "Lazy" },
}, opts)
