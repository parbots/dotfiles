return {
    {
        "stevearc/dressing.nvim",
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.input = function(...)
                require("lazy").load({
                    plugins = {
                        "dressing.nvim",
                    },
                })

                return vim.ui.input(...)
            end

            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(...)
                require("lazy").load({
                    plugins = {
                        "dressing.nvim",
                    },
                })

                return vim.ui.select(...)
            end
        end,
        opts = {
            input = {
                enabled = true,

                default_prompt = "Input:",
                title_pos = "left",

                insert_only = false,
                start_in_insert = true,

                min_width = 0.2,
                prefer_width = 0.4,
                max_width = 0.8,

                relative = "editor",

                border = "solid",
                win_options = {
                    winblend = 10,

                    wrap = false,

                    list = true,
                    listchars = "tab:❘-,trail:·,lead:·,extends:»,precedes:«,nbsp:×",

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

            local fold_col = {
                text = { builtin.foldfunc },
                click = "v:lua.ScFa",
            }

            local num_col = {
                text = { builtin.lnumfunc, " " },
                condition = { true, builtin.not_empty },
                click = "v:lua.ScFa",
            }
            local sign_col = {
                text = { "%s" },
                click = "v:lua.ScSa",
            }

            return {
                setopt = true,
                thousands = false,
                relculright = false,

                segments = {
                    fold_col,
                    sign_col,
                    num_col,
                },
            }
        end,
        config = true,
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
        config = true,
    },
}
