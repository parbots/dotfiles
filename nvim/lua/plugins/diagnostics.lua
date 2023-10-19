return {
    {
        "folke/trouble.nvim",
        keys = {
            {
                "<leader>tt",
                "<CMD> TroubleToggle <CR>",
                desc = "Toggle (Trouble)",
            },
            {
                "<leader>tr",
                "<CMD> TroubleRefresh <CR>",
                desc = "Refresh (Trouble)",
            },
            {
                "<leader>td",
                "<CMD> TroubleToggle document_diagnostics <CR>",
                desc = "Document Diagnostics (Trouble)",
            },
            {
                "<leader>tw",
                "<CMD> TroubleToggle workspace_diagnostics <CR>",
                desc = "Workspace Diagnostics (Trouble)",
            },
            {
                "<leader>tq",
                "<CMD> TroubleToggle quickfix <CR>",
                desc = "Quickfix (Trouble)",
            },
            {
                "<leader>tll",
                "<CMD> TroubleToggle loclist <CR>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>tlr",
                "<CMD> TroubleToggle lsp_references <CR>",
                desc = "References (Trouble)",
            },
            {
                "<leader>tld",
                "<CMD> TroubleToggle lsp_definitions <CR>",
                desc = "Definitions (Trouble)",
            },
            {
                "<leader>tlt",
                "<CMD> TroubleToggle lsp_type_definitions <CR>",
                desc = "Type Definitions (Trouble)",
            },
        },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            position = "bottom",
            height = 10,
            width = 50,
            padding = false,

            icons = true,
            group = true,

            multiline = true,
            indent_lines = true,

            win_config = {
                border = "none",
            },

            use_diagnostic_signs = true,
        },
    },
}
