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
                DEBUG = "",
                ERROR = "",
                INFO = "",
                TRACE = "✎",
                WARN = "",
                HINT = "",
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
        opts = function()
            local noice_util = require("util.notifications").noice

            return {
                cmdline = {
                    enabled = true,

                    view = "cmdline_popup",

                    format = {
                        search_up = {
                            view = "cmdline",
                        },

                        search_down = {
                            view = "cmdline",
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
                            },
                        },
                        filter_opts = { reverse = true },
                    },
                },

                notify = {
                    enabled = true,

                    view = "notify",
                },

                lsp = noice_util.lsp,

                markdown = {
                    hover = {
                        -- vim help links
                        ["|(%S-)|"] = vim.cmd.help,
                        -- markdown links
                        ["%[.-%]%((%S-)%)"] = require("noice.util").open,
                    },

                    highlights = {
                        ["|%S-|"] = "@text.reference",
                        ["@%S+"] = "@parameter",
                        ["^%s*(Parameters:)"] = "@text.title",
                        ["^%s*(Return:)"] = "@text.title",
                        ["^%s*(See also:)"] = "@text.title",
                        ["{%S-}"] = "@parameter",
                    },
                },

                health = {
                    checker = true,
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

                views = noice_util.views,
                routes = noice_util.routes,

                format = {
                    level = {
                        icons = {
                            error = "",
                            warn = "",
                            info = "",
                        },
                    },
                },
            }
        end,
    },
}
