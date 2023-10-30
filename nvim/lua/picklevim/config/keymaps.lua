local opts = {
    noremap = true,
    silent = true,
}

require("picklevim.util.keymap").map({
    -- #########################################################################
    -- # General
    -- #########################################################################

    -- Unmap space
    { { "n", "v" }, "<space>", "<nop>", { desc = "Leader" } },

    -- Easier command mode
    { { "n" }, ";", ":", { desc = "Command Mode", silent = false } },

    -- Easier quitting
    { { "n" }, "Q", "<cmd> q <cr>", { desc = "Quit" } },
    { { "n" }, "qq", "<cmd> q <cr>", { desc = "Quit" } },

    -- Easier writing
    { { "n" }, "<leader>ww", "<cmd> w <cr>", { desc = "Write File" } },
    { { "n" }, "<C-s>", "<cmd> w <cr>", { desc = "Write File" } },

    -- #########################################################################
    -- # Movement
    -- #########################################################################

    -- Move cursor based on physical lines, not the actual lines
    {
        { "n", "x" },
        "k",
        "v:count == 0 ? 'gk' : 'k'",
        { desc = "Up", expr = true, silent = false },
    },
    {
        { "n", "x" },
        "j",
        "v:count == 0 ? 'gj' : 'j'",
        { desc = "Down", expr = true, silent = false },
    },

    -- Move cursor in insert mode and command mode
    { { "i", "c" }, "<M-h>", "<left>", { desc = "Left" } },
    { { "i", "c" }, "<M-j>", "<down>", { desc = "Down" } },
    { { "i", "c" }, "<M-k>", "<up>", { desc = "Up" } },
    { { "i", "c" }, "<M-l>", "<right>", { desc = "Right" } },

    -- Goto beginning and end of line in insert and command mode
    { { "i", "c" }, "<C-a>", "<home>", { desc = "Goto Start (Line)" } },
    { { "i", "c" }, "<C-e>", "<end>", { desc = "Goto End (Line)" } },

    -- Center the screen when jumping up and down
    { { "n" }, "<C-u>", "<C-u>zz", { desc = "Scroll Up" } },
    { { "n" }, "<C-d>", "<C-d>zz", { desc = "Scroll Down" } },

    -- #########################################################################
    -- # Searching
    -- #########################################################################

    -- Center Search
    { { "n" }, "n", "nzz", { desc = "Next (Search)" } },
    { { "n" }, "N", "Nzz", { desc = "Previous (Search)" } },

    -- Hide Search
    { { "n" }, "<esc>", "<cmd> noh <cr>", { desc = "Hide (Search)" } },
    { { "n" }, "\\", "<cmd> noh <cr>", { desc = "Hide (Search)" } },

    -- #########################################################################
    -- # Editing
    -- #########################################################################

    -- Change text without putting it into the vim register
    { { "n" }, "c", '"_c', { desc = "+change" } },
    { { "n" }, "C", '"_C', { desc = "Change to End (Line)" } },
    { { "n" }, "cc", '"_cc', { desc = "Change (Line)" } },
    { { "x" }, "c", '"_c', { desc = "+change" } },

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
        { desc = "Join Line" },
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
        { desc = "Join Visual Lines" },
    },

    -- #########################################################################
    -- # Buffers
    -- #########################################################################

    -- Goto Next and Previous
    { { "n" }, "<tab>", "<cmd> bnext <cr>", { desc = "Goto Next (Buffer)" } },
    {
        { "n" },
        "<s-tab>",
        "<cmd> bprevious <cr>",
        { desc = "Goto Previous (Buffer)" },
    },

    {
        { "n" },
        "<leader>bn",
        "<cmd> bnext <cr>",
        { desc = "Goto Next (Buffer)" },
    },
    {
        { "n" },
        "<leader>bp",
        "<cmd> bprevious <cr>",
        { desc = "Goto Previous (Buffer)" },
    },

    { { "n" }, "H", "<cmd> bnext <cr>", { desc = "Goto Next (Buffer)" } },
    {
        { "n" },
        "L",
        "<cmd> bprevious <cr>",
        { desc = "Goto Previous (Buffer)" },
    },

    -- Delete
    {
        { "n" },
        "<leader>x",
        "<cmd> bdelete <cr>",
        { desc = "Delete Current (Buffer)" },
    },
    {
        { "n" },
        "<leader>bx",
        "<cmd> bdelete <cr>",
        { desc = "Delete (Buffer)" },
    },
    {
        { "n" },
        "<leader>bd",
        "<cmd> bdelete <cr>",
        { desc = "Delete (Buffer)" },
    },
    {
        { "n" },
        "<leader>db",
        "<cmd> bdelete <cr>",
        { desc = "Buffer (Delete)" },
    },

    -- #########################################################################
    -- # Windows
    -- #########################################################################

    -- Splits
    { { "n" }, "<leader>ws", "<C-w>v", { desc = "Split Vertically (Window)" } },
    {
        { "n" },
        "<leader>wS",
        "<C-w>s",
        { desc = "Split Horizontally (Window)" },
    },

    -- Balance
    { { "n" }, "<leader>w=", "<C-w>=", { desc = "Balance (Window)" } },

    -- Goto
    { { "n" }, "<leader>wh", "<C-w>h", { desc = "Goto Left (Window)" } },
    { { "n" }, "<leader>wj", "<C-w>j", { desc = "Goto Down (Window)" } },
    { { "n" }, "<leader>wk", "<C-w>k", { desc = "Goto Up (Window)" } },
    { { "n" }, "<leader>wl", "<C-w>l", { desc = "Goto Right (Window)" } },

    { { "n" }, "<C-h>", "<C-w>h", { desc = "Goto Left (Window)" } },
    { { "n" }, "<C-j>", "<C-w>j", { desc = "Goto Down (Window)" } },
    { { "n" }, "<C-k>", "<C-w>k", { desc = "Goto Up (Window)" } },
    { { "n" }, "<C-l>", "<C-w>l", { desc = "Goto Right (Window)" } },

    { { "i" }, "<C-h>", "<esc><C-w><C-h>gi", { desc = "Goto Left (Window)" } },
    { { "i" }, "<C-j>", "<esc><C-w><C-j>gi", { desc = "Goto Down (Window)" } },
    { { "i" }, "<C-k>", "<esc><C-w><C-k>gi", { desc = "Goto Up (Window)" } },
    { { "i" }, "<C-l>", "<esc><C-w><C-l>gi", { desc = "Goto Right (Window)" } },

    {
        { "t" },
        "<C-h>",
        "<cmd> wincmd h <cr>",
        { desc = "Goto Left (Window)" },
    },
    {
        { "t" },
        "<C-j>",
        "<cmd> wincmd j <cr>",
        { desc = "Goto Down (Window)" },
    },
    { { "t" }, "<C-k>", "<cmd> wincmd k <cr>", { desc = "Goto Up (Window)" } },
    {
        { "t" },
        "<C-l>",
        "<cmd> wincmd l <cr>",
        { desc = "Goto Right (Window)" },
    },

    -- Move
    { { "n" }, "<leader>wH", "<C-w>H", { desc = "Move Left (Window)" } },
    { { "n" }, "<leader>wJ", "<C-w>J", { desc = "Move Down (Window)" } },
    { { "n" }, "<leader>wK", "<C-w>K", { desc = "Move Up (Window)" } },
    { { "n" }, "<leader>wL", "<C-w>L", { desc = "Move Right (Window)" } },

    -- Delete
    { { "n" }, "<leader>wx", "<C-w>q", { desc = "Delete (Window)" } },
    { { "n" }, "<leader>dw", "<C-w>q", { desc = "Window (Delete)" } },

    -- #########################################################################
    -- # Tabs
    -- #########################################################################

    -- Goto Nth
    { { "n" }, "<leader>t1", "<cmd> tabn 1 <cr>", { desc = "Goto 1 (Tab)" } },
    { { "n" }, "<leader>t2", "<cmd> tabn 2 <cr>", { desc = "Goto 2 (Tab)" } },
    { { "n" }, "<leader>t3", "<cmd> tabn 3 <cr>", { desc = "Goto 3 (Tab)" } },
    { { "n" }, "<leader>t4", "<cmd> tabn 4 <cr>", { desc = "Goto 4 (Tab)" } },
    { { "n" }, "<leader>t5", "<cmd> tabn 5 <cr>", { desc = "Goto 5 (Tab)" } },
    { { "n" }, "<leader>t6", "<cmd> tabn 6 <cr>", { desc = "Goto 6 (Tab)" } },
    { { "n" }, "<leader>t7", "<cmd> tabn 7 <cr>", { desc = "Goto 7 (Tab)" } },
    { { "n" }, "<leader>t8", "<cmd> tabn 8 <cr>", { desc = "Goto 8 (Tab)" } },
    { { "n" }, "<leader>t9", "<cmd> tabn 9 <cr>", { desc = "Goto 9 (Tab)" } },

    -- Goto Next and Previous
    {
        { "n" },
        "<leader>tn",
        "<cmd> tabnext <cr>",
        { desc = "Goto Next (Tab)" },
    },
    {
        { "n" },
        "<leader>tp",
        "<cmd> tabprevious <cr>",
        { desc = "Goto Previous (Tab)" },
    },

    -- Delete
    { { "n" }, "<leader>tx", "<cmd> tabclose <cr>", { desc = "Delete (Tab)" } },
    { { "n" }, "<leader>dt", "<cmd> tabclose <cr>", { desc = "Tab (Delete)" } },

    -- #########################################################################
    -- # Lazy
    -- #########################################################################
    { { "n" }, "<leader>ol", "<cmd> Lazy <cr>", { desc = "Lazy" } },
}, opts)
