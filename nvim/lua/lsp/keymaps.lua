---@class lsp.keymap
---@field[1] string[]
---@field[2] string
---@field[3] string|function
---@field[4] string
---@field[5] table?
---@field method string?

---@class lsp.keymaps
---@type lsp.keymap[]
local M = {
    -- Lsp Info
    {
        { "n" },
        "<leader>li",
        "<cmd> LspInfo <cr>",
        "Info (Lsp)",
    },

    -- Inlay Hints
    {
        { "n" },
        "<leader>lh",
        function()
            vim.lsp.inlay_hint(0, nil)
        end,
        "Toggle Inlay Hints (Lsp)",
        method = "textDocument/inlayHint",
    },
    {
        { "n", "i", "v" },
        "<C-n>",
        function()
            vim.lsp.inlay_hint(0, nil)
        end,
        "Toggle Inlay Hints (Lsp)",
        method = "textDocument/inlayHint",
    },

    -- Hover
    {
        { "n" },
        "K",
        require("util.lsp").show_hover,
        "Hover (Lsp)",
        method = "textDocument/hover",
    },

    -- Signature Help
    {
        { "n" },
        "<leader>lk",
        vim.lsp.buf.signature_help,
        "Signature Help (Lsp)",
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
        "Goto Definition (Lsp)",
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
        "Goto References (Lsp)",
        method = "textDocument/references",
    },
    {
        { "n" },
        "gD",
        vim.lsp.buf.declaration,
        "Goto Declaration (Lsp)",
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
        "Goto Implementation (Lsp)",
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
        "Goto Type Definition (Lsp)",
        method = "textDocument/typeDefinition",
    },

    -- Code Actions
    {
        { "n", "v" },
        "<leader>lca",
        vim.lsp.buf.code_action,
        "Code Action (Lsp)",
        method = "textDocument/codeAction",
    },
    {
        { "n", "v" },
        "<leader>lcA",
        function()
            vim.lsp.buf.code_action({
                context = {
                    only = {
                        "source",
                    },
                    diagnostics = {},
                },
            })
        end,
        "Source Action (Lsp)",
        method = "textDocument/codeAction",
    },
}

return M
