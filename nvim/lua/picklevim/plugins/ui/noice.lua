local icons = require("picklevim.config").icons

return {
    {
        "rcarriga/nvim-notify",
        keys = {
            {
                "<leader>un",
                function()
                    require("notify").dismiss({
                        silent = false,
                        pending = true,
                    })
                end,
                desc = "Dismiss all (Notify)",
            },
        },
        opts = {
            level = 0,
            timeout = 3000,

            icons = {
                ERROR = icons.diagnostics.Error,
                WARN = icons.diagnostics.Warn,
                INFO = icons.diagnostics.Info,
                HINT = icons.diagnostics.Hint,

                DEBUG = "",
                TRACE = "✎",
            },

            fps = 30,
            render = "default",
            stages = "fade_in_slide_out",

            top_down = true,

            max_height = function()
                return math.floor(vim.o.lines * 0.80)
            end,

            minimum_width = 20,
            max_width = function()
                return math.floor(vim.o.columns * 0.80)
            end,
        },
    },

    {
        "folke/noice.nvim",
        event = { "VeryLazy" },
        cmd = { "Noice" },
        keys = {
            {
                "<leader>sna",
                function()
                    require("noice").cmd("all")
                end,
                desc = "All (Noice)",
            },
            {
                "<leader>snl",
                function()
                    require("noice").cmd("last")
                end,
                desc = "Last Message (Noice)",
            },
            {
                "<leader>snh",
                function()
                    require("noice").cmd("history")
                end,
                desc = "History (Noice)",
            },
            {
                "<leader>snd",
                function()
                    require("noice").cmd("dismiss")
                end,
                desc = "Dismiss All (Noice)",
            },
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        ---@type NoiceConfig
        opts = {
            cmdline = {
                enabled = true,

                view = "cmdline_popup",

                format = {
                    cmdline = {
                        pattern = "^:",
                        icon = icons.noice.cmdline,
                        lang = "vim",
                    },

                    search_up = {
                        view = "cmdline",

                        kind = "search",
                        pattern = "^%?",
                        icon = icons.noice.search_up,
                        lang = "regex",
                    },

                    search_down = {
                        view = "cmdline",

                        kind = "search",
                        pattern = "^/",
                        icon = icons.noice.search_down,
                        lang = "regex",
                    },

                    filter = {
                        pattern = "^:%s*!",
                        icon = icons.noice.filter,
                        lang = "bash",
                    },

                    lua = {
                        pattern = {
                            "^:%s*lua%s+",
                            "^:%s*lua%s*=%s*",
                            "^:%s*=%s*",
                        },
                        icon = icons.noice.lua,
                        lang = "lua",
                    },

                    help = {
                        pattern = "^:%s*he?l?p?%s+",
                        icon = icons.noice.help,
                    },
                },
            },

            messages = {
                enabled = true,

                view = "notify",
                view_error = "notify",
                view_warn = "notify",
                view_history = "popup",
                view_search = "virtualtext",
            },

            popupmenu = {
                enabled = true,

                backend = "nui",
            },

            redirect = {
                view = "popup",

                filter = {
                    event = "msg_show",
                },
            },

            commands = {
                history = {
                    view = "popup",
                },

                last = {
                    view = "popup",

                    filter_opts = { count = 1 },
                },

                errors = {
                    view = "popup",

                    filter = {
                        any = {
                            { error = true },
                            { warning = true },
                            { info = true },
                            { hint = true },
                        },
                    },
                    filter_opts = { reverse = true },
                },
            },

            lsp = {
                progress = {
                    enabled = true,

                    throttle = 30,
                },

                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },

                hover = {
                    enabled = true,

                    silent = true,
                },

                signature = {
                    enabled = true,

                    auto_open = {
                        enabled = true,

                        throttle = 30,
                    },
                },

                documentation = {
                    view = "hover",
                    ---@type NoiceViewOptions
                    opts = {
                        lang = "markdown",
                        replace = true,
                        render = "plain",
                        format = { "{message}" },
                    },
                },
            },

            smart_move = {
                enabled = true,

                excluded_filetypes = {
                    "cmp_menu",
                    "cmp_docs",
                    "notify",
                },
            },

            presets = {
                bottom_search = false,
                command_palette = false,
                long_message_to_split = false,
                inc_rename = true,
                lsp_doc_border = true,
            },

            throttle = 30,

            views = {
                cmdline_popup = {
                    position = {
                        row = "25%",
                        col = "50%",
                    },

                    size = {
                        width = 60,
                        height = "auto",
                    },

                    border = {
                        style = "none",
                        padding = { 1, 1 },
                    },

                    win_options = {
                        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
                        winblend = 10,
                    },
                },

                popupmenu = {
                    size = {
                        min_width = 10,
                        width = "auto",

                        height = "auto",
                        max_height = 20,
                    },

                    win_options = {
                        winblend = 10,
                    },
                },

                popup = {
                    size = {
                        width = math.floor(vim.o.columns * 0.80),
                        height = math.floor(vim.o.lines * 0.80),
                    },

                    border = {
                        style = "none",
                        padding = { 1, 1 },
                    },

                    win_options = {
                        winblend = 10,
                    },
                },

                hover = {
                    position = {
                        row = 2,
                        col = 1,
                    },

                    size = {
                        max_width = math.floor(vim.o.columns * 0.80),
                        max_height = math.floor(vim.o.lines * 0.80),
                    },

                    border = {
                        style = "none",
                        padding = { 1, 1 },
                    },

                    win_options = {
                        winblend = 10,

                        wrap = true,
                        linebreak = true,

                        signcolumn = "no",
                        cursorcolumn = false,
                        foldcolumn = "0",

                        list = true,
                        listchars = "tab:❘-,trail:·,lead:·,extends:»,precedes:«,nbsp:×",

                        concealcursor = "n",
                        conceallevel = 2,
                    },
                },

                confirm = {
                    border = {
                        style = "none",
                        padding = { 1, 1 },
                    },
                },
            },

            routes = {
                {
                    filter = {
                        event = "msg_show",
                        any = {
                            { find = "%d+L, %d+B" },
                            { find = "; after #%d+" },
                            { find = "; before #%d+" },
                            { find = "lines" },
                            { find = "yanked" },
                        },
                    },

                    view = "mini",
                },
            },

            format = {
                level = {
                    icons = {
                        error = icons.diagnostics.Error,
                        warn = icons.diagnostics.Warn,
                        info = icons.diagnostics.Info,
                        hint = icons.diagnostics.Hint,
                    },
                },
            },
        },
    },
}
