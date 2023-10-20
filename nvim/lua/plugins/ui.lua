local Util = require("util")

return {

    -- #########################################################################
    -- # alpha-nvim
    -- #########################################################################
    {
        "goolord/alpha-nvim",
        event = { "VimEnter" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")

            dashboard.opts.layout[1].val = 5

            dashboard.section.header.val = {
                [[                               __                ]],
                [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
                [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
                [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
                [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
                [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
            }
            dashboard.section.header.opts.hl = "AlphaHeader"

            dashboard.opts.layout[3].val = 1

            dashboard.section.buttons.val = {
                {
                    type = "text",
                    val = " ",
                    opts = {
                        position = "center",
                        hl = "AlphaHeaderLabel",
                    },
                },

                {
                    type = "padding",
                    val = 0,
                },

                dashboard.button(
                    "e",
                    "󰝒  >  New File",
                    "<cmd> ene <BAR> startinsert <cr>"
                ),
                dashboard.button(
                    "f",
                    "󰱼  >  Find File",
                    "<cmd> Telescope find_files <cr>"
                ),
                dashboard.button(
                    "w",
                    "  >  Find word",
                    "<cmd> Telescope live_grep <cr>"
                ),
                dashboard.button("l", "󰏗  >  Lazy", "<cmd> Lazy <cr>"),
                dashboard.button("q", "  >  Quit", "<cmd> qa <cr>"),
            }
            dashboard.section.buttons.opts.spacing = 1
            for _, item in ipairs(dashboard.section.buttons.val) do
                if item.type == "button" then
                    item.opts.hl = "AlphaButtons"
                    item.opts.hl_shortcut = "AlphaShortcut"
                end
            end

            local fortune = require("alpha.fortune")
            dashboard.section.footer.val = fortune()
            dashboard.section.footer.opts.hl = "AlphaFooter"

            dashboard.config.opts.noautocmd = true

            alpha.setup(dashboard.config)

            vim.api.nvim_create_autocmd("User", {
                pattern = { "VeryLazy", "VimEnter", "UIEnter" },
                callback = function()
                    local stats = require("lazy.stats").stats()

                    dashboard.section.buttons.val[1].val = "󱐋 Lazy loaded "
                        .. stats.loaded
                        .. " / "
                        .. stats.count
                        .. " plugins in "
                        .. stats.startuptime
                        .. "ms 󱐋"

                    pcall(vim.cmd.AlphaRedraw)
                end,
            })
        end,
    },

    -- #########################################################################
    -- # lualine.nvim
    -- #########################################################################
    {
        "nvim-lualine/lualine.nvim",
        event = { "LazyFile" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        init = function()
            vim.g.lualine_laststatus = vim.o.laststatus

            if vim.fn.argc(-1) > 0 then
                vim.o.statusline = ""
            else
                vim.o.laststatus = 0
            end
        end,
        opts = function()
            local lualine_require = require("lualine_require")
            lualine_require.require = require

            vim.o.laststatus = vim.g.lualine_laststatus

            return {

                options = {
                    theme = "catppuccin",

                    always_divide_middle = true,

                    globalstatus = true,

                    disabled_filetypes = {
                        statusline = {
                            "alpha",
                        },
                    },

                    refresh = {
                        statusline = 1000,
                    },
                },

                extensions = {
                    "lazy",
                    "man",
                    "mason",
                    "trouble",
                },

                sections = {
                    -- Left
                    lualine_a = {
                        {
                            "mode",

                            separator = "",
                            padding = {
                                left = 1,
                                right = 0,
                            },
                        },
                    },
                    lualine_b = {
                        {
                            "branch",

                            separator = "",
                            padding = {
                                left = 1,
                                right = 0,
                            },
                        },
                        {
                            "diff",

                            separator = "",
                            padding = {
                                left = 1,
                                right = 0,
                            },
                        },
                    },
                    lualine_c = {
                        {
                            "diagnostics",

                            sources = {
                                "nvim_diagnostic",
                            },
                            update_in_insert = false,
                            always_visible = false,

                            separator = "",
                            padding = {
                                left = 1,
                                right = 0,
                            },
                        },
                        {
                            "filename",

                            file_status = true,
                            newfile_status = true,
                            path = 1,
                            shorting_target = 50,
                            symbols = {
                                modified = "[+]",
                                readonly = "[-]",
                                unnamed = "[No Name]",
                                newfile = "[New]",
                            },

                            separator = "",
                            padding = {
                                left = 1,
                                right = 0,
                            },
                        },
                    },

                    -- Right
                    lualine_x = {
                        Util.lazy_status(),
                        Util.lsp.active_clients,
                    },
                    lualine_y = {
                        {
                            "filetype",

                            icon_only = false,
                            separator = "",
                            padding = {
                                left = 0,
                                right = 1,
                            },
                        },
                    },
                    lualine_z = {
                        {
                            "progress",

                            separator = "",
                            padding = {
                                left = 0,
                                right = 1,
                            },
                        },
                        {
                            "location",

                            separator = "",
                            padding = {
                                left = 0,
                                right = 1,
                            },
                        },
                    },
                },
            }
        end,
    },

    -- #########################################################################
    -- # noice.nvim
    -- #########################################################################
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
        opts = {
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

            format = {
                level = {
                    icons = {
                        error = "",
                        warn = "",
                        info = "",
                    },
                },
            },
        },
    },

    -- #########################################################################
    -- # Extras
    -- #########################################################################
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
                    "nui",
                    "builtin",
                },

                nui = {
                    border = {
                        style = "none",
                    },

                    win_options = {
                        winblend = 10,
                    },
                },

                builtin = {
                    min_width = 0.2,
                    max_width = 0.8,

                    min_height = 0.2,
                    max_height = 0.8,

                    border = "none",
                    win_options = {
                        winblend = 10,
                    },

                    show_numbers = true,

                    mappings = {
                        ["<Esc>"] = "Close",
                        ["<C-c>"] = "Close",
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
                    { text = { "%C" }, click = "v:lua.ScFa" },
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
