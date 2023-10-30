local lsp_util = require("picklevim.util.lsp")

---@class picklevim.lsp.keymap
---@field[1] picklevim.keymap.mode
---@field[2] picklevim.keymap.lhs
---@field[3] picklevim.keymap.rhs
---@field[4] picklevim.keymap.opts
---@field method? string

---@class picklevim.lsp.keymaps
---@type table<string, picklevim.lsp.keymap>
local M = {
    -- Lsp Info
    {
        { "n" },
        "<leader>li",
        "<cmd> LspInfo <cr>",
        { desc = "Info (Lsp)" },
    },

    -- Inlay Hints
    {
        { "n" },
        "<leader>lh",
        lsp_util.inlay_hints.toggle,
        { desc = "Toggle Inlay Hints (Lsp)" },
        method = "textDocument/inlayHint",
    },
    {
        { "n", "i", "v" },
        "<C-n>",
        lsp_util.inlay_hints.toggle,
        { desc = "Toggle Inlay Hints (Lsp)" },
        method = "textDocument/inlayHint",
    },

    -- Hover
    {
        { "n" },
        "K",
        lsp_util.hover,
        { desc = "Hover (Lsp)" },
        method = "textDocument/hover",
    },

    -- Signature Help
    {
        { "n" },
        "<leader>lk",
        vim.lsp.buf.signature_help,
        { desc = "Signature Help (Lsp)" },
        method = "textDocument/signatureHelp",
    },

    -- Goto
    {
        { "n" },
        "gd",
        function()
            require("telescope.builtin").lsp_definitions({
                reuse_win = true,
            })
        end,
        { desc = "Goto Definition (Lsp)" },
        method = "textDocument/definition",
    },
    {
        { "n" },
        "gr",
        function()
            require("telescope.builtin").lsp_references({
                reuse_win = true,
            })
        end,
        { desc = "Goto References (Lsp)" },
        method = "textDocument/references",
    },
    {
        { "n" },
        "gD",
        vim.lsp.buf.declaration,
        { desc = "Goto Declaration (Lsp)" },
        method = "textDocument/declaration",
    },
    {
        { "n" },
        "gI",
        function()
            require("telescope.builtin").lsp_implementations({
                reuse_win = true,
            })
        end,
        { desc = "Goto Implementation (Lsp)" },
        method = "textDocument/implementation",
    },
    {
        { "n" },
        "gy",
        function()
            require("telescope.builtin").lsp_type_definitions({
                reuse_win = true,
            })
        end,
        { desc = "Goto Type Definition (Lsp)" },
        method = "textDocument/typeDefinition",
    },

    -- Code Actions
    {
        { "n", "v" },
        "<leader>lca",
        vim.lsp.buf.code_action,
        { desc = "Code Action (Lsp)" },
        method = "textDocument/codeAction",
    },
    {
        { "n", "v" },
        "<leader>lcA",
        function()
            vim.lsp.buf.code_action({
                context = {
                    only = { "source" },
                    diagnostics = {},
                },
            })
        end,
        { desc = "Source Action (Lsp)" },
        method = "textDocument/codeAction",
    },
}

return M
