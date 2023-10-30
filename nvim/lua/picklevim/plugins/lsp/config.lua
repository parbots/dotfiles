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
        ---@type picklevim.lsp.opts
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
            require("picklevim.util.lsp").setup(opts)
        end,
    },
}
