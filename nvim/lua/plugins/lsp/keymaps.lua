local Util = require("util")

local M = {}

M.keymaps = nil

M.get = function()
    if M.keymaps then
        return M.keymaps
    end

    M.keymaps = {
        { { "n" }, "<leader>li", "<cmd> LspInfo <cr>", "Info (Lsp)" },

        {
            { "n" },
            "<leader>lh",
            function()
                vim.lsp.inlay_hint(0, nil)
            end,
            "Toggle Inlay Hints (Lsp)",
            has = "inlayHint",
        },
        {
            { "n", "i", "v" },
            "<C-n>",
            function()
                vim.lsp.inlay_hint(0, nil)
            end,
            "Toggle Inlay Hints (Lsp)",
            has = "inlayHint",
        },

        {
            { "n" },
            "K",
            Util.lsp.show_hover,
            "Hover (Lsp)",
            has = "hover",
        },

        {
            { "n" },
            "gd",
            function()
                require("telescope.builtin").lsp_definitions({
                    reuse_win = true,
                })
            end,
            "Goto Definition (Lsp)",
            has = "definition",
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
            has = "references",
        },
        {
            { "n" },
            "gD",
            vim.lsp.buf.declaration,
            "Goto Declaration (Lsp)",
            has = "declaration",
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
            has = "implementation",
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
            has = "typeDefinition",
        },

        {
            { "n" },
            "<leader>gK",
            vim.lsp.buf.signature_help,
            "Signature Help (Lsp)",
            has = "signatureHelp",
        },

        {
            { "n", "v" },
            "<leader>ca",
            vim.lsp.buf.code_action,
            "Code Action (Lsp)",
            has = "codeAction",
        },
        {
            { "n", "v" },
            "<leader>cA",
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
            has = "codeAction",
        },
    }

    return M.keymaps
end

M.has = function(buffer, method)
    method = method:find("/") and method or "textDocument/" .. method
    local clients = Util.lsp.get_clients({ bufnr = buffer })
    for _, client in ipairs(clients) do
        if client.supports_method(method) then
            return true
        end
    end

    return false
end

M.resolve = function(buffer)
    local keymaps = M.get()
    local opts = Util.opts("nvim-lspconfig")
    local clients = Util.lsp.get_clients({ bufnr = buffer })

    for _, client in ipairs(clients) do
        local client_keymaps = opts.servers[client.name]
                and opts.servers[client.name].keys
            or {}
        vim.list_extend(keymaps, client_keymaps)
    end

    return keymaps
end

M.on_attach = function(_, buffer)
    vim.bo[buffer].omnifunc = "v:lua.vim.lsp.omnifunc"

    local keymaps = M.resolve(buffer)

    for _, keymap in pairs(keymaps) do
        if not keymap.has or M.has(buffer, keymap.has) then
            Util.map({
                {
                    keymap[1],
                    keymap[2],
                    keymap[3],
                    keymap[4],
                    {
                        buffer = buffer,
                    },
                },
            })
        end
    end
end

return M
