return {

    -- #########################################################################
    -- # Lspconfig
    -- #########################################################################
    {
        "neovim/nvim-lspconfig",
        lazy = true,
        event = { "LazyFile" },
        version = false,
        dependencies = {
            {
                "williamboman/mason-lspconfig.nvim",
                dependencies = { "williamboman/mason.nvim" },
            },

            { "folke/neodev.nvim", opts = {} },
            { "simrat39/rust-tools.nvim" },
            {
                "pmizio/typescript-tools.nvim",
                dependencies = { "nvim-lua/plenary.nvim" },
            },
        },
        opts = {
            inlay_hints = false,

            diagnostics = {
                underline = true,
                update_in_insert = false,
                virtual_text = {
                    spacing = 4,
                    source = "if_many",
                    prefix = "icons",
                },
                severity_sort = true,
            },

            capabilities = {
                workspace = {
                    didChangeWatchedFiles = {
                        dynamicRegistration = false,
                    },
                },
            },
        },
        config = function(_, opts)
            local lsp_util = require("util.lsp")

            lsp_util.keymaps.setup()
            lsp_util.inlay_hints.setup(opts.inlay_hints)
            lsp_util.diagnostics.setup(opts.diagnostics)
            lsp_util.servers.setup(opts.capabilities)
        end,
    },
}
