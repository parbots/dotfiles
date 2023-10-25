---@class util.notifications
local M = {}

M.noice = {
    lsp = {
        progress = {
            enabled = true,

            format = "lsp_progress",
            format_done = "lsp_progress_done",

            throttle = 30,

            view = "mini",
        },

        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },

        hover = {
            enabled = true,

            silent = true,

            view = nil,
        },

        signature = {
            enabled = true,

            auto_open = {
                enabled = true,

                trigger = true,
                luasnip = true,
                throttle = 30,
            },

            view = nil,
        },

        message = {
            enabled = true,

            view = "notify",
        },

        documentation = {
            view = "hover",

            opts = {
                lang = "markdown",
                replace = true,
                render = "plain",
                format = { "{message}" },
                win_options = {
                    concealcursor = "n",
                    conceallevel = 3,
                },
            },
        },
    },

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

            border = {
                style = "none",
                padding = { 1, 1 },
            },

            win_options = {
                winblend = 10,
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
}

return M
