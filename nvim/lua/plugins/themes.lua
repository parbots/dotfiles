return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        event = { "UIEnter" },
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

            integrations = {
                alpha = true,
                cmp = true,
                dropbar = {
                    enabled = true,
                    color_mode = true,
                },
                flash = true,
                gitsigns = true,
                lsp_trouble = true,
                mason = true,
                mini = true,
                neogit = true,
                noice = true,
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
                notify = true,
                octo = true,
                semantic_tokens = true,
                treesitter = true,
                treesitter_context = true,
                telescope = {
                    enabled = true,
                    style = "nvchad",
                },
                which_key = true,
            },
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)

            vim.cmd.colorscheme("catppuccin")
        end,
    },
}
