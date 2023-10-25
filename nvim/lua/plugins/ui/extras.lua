return {
    {
        "stevearc/dressing.nvim",
        event = { "VeryLazy" },
        opts = {
            input = {
                enabled = true,

                default_prompt = "Input:",
                title_pos = "center",

                insert_only = false,
                start_in_insert = true,

                min_width = 0.2,
                prefer_width = 0.4,
                max_width = 0.8,

                border = "none",
                win_options = {
                    winblend = 10,

                    wrap = false,

                    list = true,
                    listchars = {
                        tab = "❘-",
                        trail = "·",
                        lead = "·",
                        extends = "»",
                        precedes = "«",
                        nbsp = "×",
                    },

                    sidescrolloff = 8,
                },

                mappings = {
                    n = {
                        ["<Esc>"] = "Close",
                        ["q"] = "Close",
                        ["<cr>"] = "Confirm",
                    },

                    i = {
                        ["<C-c>"] = "Close",
                        ["<cr>"] = "Confirm",
                        ["<Up>"] = "HistoryPrev",
                        ["<Down>"] = "HistoryNext",
                    },
                },
            },

            select = {
                enabled = true,

                trim_prompt = true,

                backend = {
                    "telescope",
                    "builtin",
                },

                telescope = require("telescope.themes").get_ivy(),

                builtin = {
                    min_width = 0.2,
                    max_width = 0.8,

                    min_height = 0.2,
                    max_height = 0.8,

                    border = "solid",
                    win_options = {
                        winblend = 10,
                    },

                    show_numbers = true,

                    mappings = {
                        ["<Esc>"] = "Close",
                        ["<C-c>"] = "Close",
                        ["q"] = "Close",
                        ["<cr>"] = "Confirm",
                    },
                },
            },
        },
    },

    {
        "luukvbaal/statuscol.nvim",
        event = { "LazyFile" },
        dependencies = { "lewis6991/gitsigns.nvim" },
        opts = function()
            local builtin = require("statuscol.builtin")

            return {
                setopt = true,
                thousands = false,
                relculright = false,

                segments = {
                    -- Fold column
                    { text = { builtin.foldfunc }, click = "v:lua.ScFa" },

                    -- Sign column
                    { text = { "%s" }, click = "v:lua.ScSa" },

                    -- Number column
                    {
                        text = { builtin.lnumfunc, " " },
                        condition = { true, builtin.not_empty },
                        click = "v:lua.ScFa",
                    },
                },
            }
        end,
    },

    {
        "m4xshen/smartcolumn.nvim",
        event = { "LazyFile" },
        opts = {
            colorcolumn = "80",
            scope = "file",

            disabled_filetypes = {
                "alpha",
                "checkhealth",
                "help",
                "lazy",
                "lspinfo",
                "man",
                "markdown",
                "mason",
                "notify",
                "oil",
                "text",
                "trouble",
            },
        },
    },

    {
        "nvim-tree/nvim-web-devicons",
        opts = {
            color_icons = true,
            default = true,
            strict = true,
        },
    },
}
