return {
    {
        "folke/trouble.nvim",
        cmd = { "Trouble", "TroubleRefresh", "TroubleToggle" },
        keys = {
            {
                "<leader>tt",
                "<cmd> TroubleToggle <cr>",
                desc = "Toggle (Trouble)",
            },
            {
                "<leader>tr",
                "<cmd> TroubleRefresh <cr>",
                desc = "Refresh (Trouble)",
            },
            {
                "<leader>td",
                "<cmd> TroubleToggle document_diagnostics <cr>",
                desc = "Document Diagnostics (Trouble)",
            },
            {
                "<leader>tw",
                "<cmd> TroubleToggle workspace_diagnostics <cr>",
                desc = "Workspace Diagnostics (Trouble)",
            },
            {
                "<leader>tq",
                "<cmd> TroubleToggle quickfix <cr>",
                desc = "Quickfix (Trouble)",
            },
            {
                "<leader>tll",
                "<cmd> TroubleToggle loclist <cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>tlr",
                "<cmd> TroubleToggle lsp_references <cr>",
                desc = "References (Trouble)",
            },
            {
                "<leader>tld",
                "<cmd> TroubleToggle lsp_definitions <cr>",
                desc = "Definitions (Trouble)",
            },
            {
                "<leader>tlt",
                "<cmd> TroubleToggle lsp_type_definitions <cr>",
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
