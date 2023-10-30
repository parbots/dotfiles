return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        event = { "VeryLazy" },
        opts = {
            flavour = "mocha",

            transparent_background = false,
            show_end_of_buffer = false,
            term_colors = true,
            dim_inactive = {
                enabled = true,
                shade = "dark",
                percentage = 0.10,
            },

            no_italic = false,
            no_bold = false,
            no_underline = false,

            styles = {
                comments = { "italic" },
                conditionals = { "italic" },
                loops = {},
                functions = {},
                keywords = { "italic" },
                strings = {},
                variables = {},
                numbers = {},
                booleans = {},
                properties = {},
                types = { "italic" },
                operators = {},
            },

            integrations = {
                alpha = true,
                cmp = true,
                flash = true,
                gitsigns = true,
                illuminate = {
                    enabled = true,

                    lsp = true,
                },
                lsp_trouble = true,
                mason = true,
                markdown = true,
                mini = {
                    enabled = true,
                },
                native_lsp = {
                    enabled = true,

                    virtual_text = {
                        errors = { "italic" },
                        hints = { "italic" },
                        warnings = { "italic" },
                        information = { "italic" },
                    },

                    underlines = {
                        errors = { "undercurl" },
                        hints = { "undercurl" },
                        warnings = { "undercurl" },
                        information = { "undercurl" },
                    },

                    inlay_hints = {
                        background = true,
                    },
                },
                neogit = true,
                noice = true,
                notify = true,
                octo = true,
                semantic_tokens = true,
                telescope = {
                    enabled = true,
                },
                treesitter = true,
                treesitter_context = true,
                which_key = true,
            },
        },
        config = true,
    },
}
