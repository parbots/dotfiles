local keymap_util = require("util.keymap")

local global_opts = {
    noremap = true,
    silent = true,
}

keymap_util.map({
    -- #########################################################################
    -- # General
    -- #########################################################################

    -- Unmap space
    { { "n", "v" }, "<space>", "<nop>", "Leader" },

    -- Easier command mode
    { { "n" }, ";", ":", "Command Mode", { silent = false } },

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
        { expr = true, silent = false },
    },
    {
        { "n", "x" },
        "j",
        "v:count == 0 ? 'gj' : 'j'",
        "Down",
        { expr = true, silent = false },
    },

    -- Move cursor in insert mode and command mode
    { { "i", "c" }, "<M-h>", "<left>", "Left" },
    { { "i", "c" }, "<M-j>", "<down>", "Down" },
    { { "i", "c" }, "<M-k>", "<up>", "Up" },
    { { "i", "c" }, "<M-l>", "<right>", "Right" },

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
    { { "n" }, "<leader>wS", "<C-w>s", "Split Horizontally (Window)" },

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

    { { "i" }, "<C-h>", "<esc><C-w><C-h>gi", "Goto Left (Window)" },
    { { "i" }, "<C-j>", "<esc><C-w><C-j>gi", "Goto Down (Window)" },
    { { "i" }, "<C-k>", "<esc><C-w><C-k>gi", "Goto Up (Window)" },
    { { "i" }, "<C-l>", "<esc><C-w><C-l>gi", "Goto Right (Window)" },

    { { "t" }, "<C-h>", "<cmd> wincmd h <cr>", "Goto Left (Window)" },
    { { "t" }, "<C-j>", "<cmd> wincmd j <cr>", "Goto Down (Window)" },
    { { "t" }, "<C-k>", "<cmd> wincmd k <cr>", "Goto Up (Window)" },
    { { "t" }, "<C-l>", "<cmd> wincmd l <cr>", "Goto Right (Window)" },

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

    -- Goto Nth
    { { "n" }, "<leader>t1", "<cmd> tabn 1 <cr>", "Goto 1 (Tab)" },
    { { "n" }, "<leader>t2", "<cmd> tabn 2 <cr>", "Goto 2 (Tab)" },
    { { "n" }, "<leader>t3", "<cmd> tabn 3 <cr>", "Goto 3 (Tab)" },
    { { "n" }, "<leader>t4", "<cmd> tabn 4 <cr>", "Goto 4 (Tab)" },
    { { "n" }, "<leader>t5", "<cmd> tabn 5 <cr>", "Goto 5 (Tab)" },
    { { "n" }, "<leader>t6", "<cmd> tabn 6 <cr>", "Goto 6 (Tab)" },
    { { "n" }, "<leader>t7", "<cmd> tabn 7 <cr>", "Goto 7 (Tab)" },
    { { "n" }, "<leader>t8", "<cmd> tabn 8 <cr>", "Goto 8 (Tab)" },
    { { "n" }, "<leader>t9", "<cmd> tabn 9 <cr>", "Goto 9 (Tab)" },

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
}, global_opts)
