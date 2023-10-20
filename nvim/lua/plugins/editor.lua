local Util = require("util")

return {

    {
        "folke/which-key.nvim",
        event = { "LazyFile" },
        keys = {
            { "<leader>", "<nop>", mode = { "n", "v" } },
        },
        opts = function()
            return {
                window = {
                    border = "none",
                    winblend = 10,
                    margin = { 0, 0, 1, 0 },
                    padding = { 1, 1, 1, 1 },
                },

                popup_mappings = {
                    scroll_up = "<C-U>",
                    scroll_down = "<C-D>",
                },

                layout = {
                    width = { min = 1, max = 100 },
                    height = { min = 1, max = 200 },
                    spacing = 1,
                    align = "center",
                },

                icons = {
                    breadcrumb = "»",
                    separator = "➜",
                    group = "+",
                },

                operators = Util.whichkey.operators,
                key_labels = Util.whichkey.get_key_labels(),

                triggers = {
                    "<leader>",

                    "c",
                    "d",
                    "g",
                    "v",
                    "y",
                    "z",

                    "<C-w>",

                    ">",
                    "<",
                },

                plugin = {
                    marks = true,
                    register = true,

                    spelling = {
                        enabled = true,
                        suggestions = 20,
                    },

                    presets = {
                        operators = false,
                        motions = true,
                        text_objects = true,
                        windows = true,
                        nav = true,
                        z = true,
                        g = true,
                    },
                },
            }
        end,
        config = function(_, opts)
            local whichkey = require("which-key")

            whichkey.setup(opts)

            Util.whichkey.register(whichkey)
        end,
    },

    {
        "folke/flash.nvim",
        event = { "LazyFile" },
        keys = {
            {
                "s",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump()
                end,
                desc = "Jump (Flash)",
            },
            {
                "S",
                mode = { "n", "x", "o" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Treesitter (Flash)",
            },
            {
                "r",
                mode = { "o" },
                function()
                    require("flash").remote()
                end,
                desc = "Remote (Flash)",
            },
            {
                "R",
                mode = { "o", "x" },
                function()
                    require("flash").treesitter_search()
                end,
                desc = "Treesitter Search (Flash)",
            },
            {
                "<C-s>",
                mode = { "c" },
                function()
                    require("flash").toggle()
                end,
                desc = "Toggle (Flash)",
            },
        },
        opts = {
            labels = "asdfghjklqwertyuiopzxcvbnm",

            search = {
                mode = "exact",
                incremental = false,

                exclude = {
                    "notify",
                    "cmp_menu",
                    "noice",
                    "flash_prompt",

                    function(win)
                        return not vim.api.nvim_win_get_config(win).focusable
                    end,
                },
            },

            jump = {
                nohlsearch = false,
                autojump = false,
                offset = nil,
            },

            label = {
                uppercase = true,

                rainbow = {
                    enabled = true,
                    shade = 9,
                },
            },

            modes = {
                search = {
                    enabled = true,

                    highlight = { backdrop = true },
                },

                char = {
                    enabled = true,

                    jump_labels = true,
                    label = { exclude = "hjkliardc" },
                    keys = { "f", "F", "t", "T", ";", "," },
                },

                treesitter = {
                    labels = "abcdefghijklmnopqrstuvwxyz",

                    search = { incremental = false },

                    label = {
                        before = true,
                        after = true,
                        style = "overlay",
                    },

                    highlight = {
                        backdrop = true,
                        matches = true,
                    },
                },
                treesitter_search = {
                    search = {
                        multi_window = true,
                        wrap = true,
                        incremental = false,
                    },

                    label = {
                        before = true,
                        after = true,
                        style = "overlay",
                    },
                },
            },
        },
    },

    {
        "nvim-pack/nvim-spectre",
        cmd = { "Spectre" },
        keys = {
            {
                "<leader>os",
                "<cmd> Spectre <cr>",
                desc = "Spectre",
            },
        },
        opts = {
            color_devicons = true,
            open_cmd = "noswapfile vnew",
            live_update = true,

            default = {
                find = {
                    cmd = "rg",
                    options = { "ignore-case", "hidden" },
                },

                replace = {
                    cmd = "sed",
                },
            },
        },
    },

    {
        "smjonas/inc-rename.nvim",
        event = { "LazyFile" },
        keys = {
            { "<leader>lr", ":IncRename ", desc = "Rename (Lsp)" },
        },
        opts = {},
    },

    {
        "mbbill/undotree",
        event = { "LazyFile" },
        keys = {
            {
                "<leader>ou",
                "<cmd> UndotreeToggle <cr>",
                desc = "Undotree",
            },
        },
        config = function()
            vim.g.undotree_ShortIndicators = 1
        end,
    },

    {
        "kylechui/nvim-surround",
        event = { "LazyFile" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            keymaps = {
                insert = "<C-G>s",
                insert_line = "<C-G>S",

                normal = "ys",
                normal_cur = "yss",
                normal_line = "yS",
                normal_line_cur = "ySS",

                visual = "gs",
                visual_line = "gS",

                delete = "ds",
                change = "cs",
                change_line = "cS",
            },
        },
    },

    {
        "windwp/nvim-autopairs",
        event = { "LazyFile" },
        opts = {
            check_ts = true,
            enable_abbr = true,

            fast_wrap = {
                map = "<M-e>",
            },
        },
    },

    {
        "numToStr/Comment.nvim",
        event = { "LazyFile" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {},
    },

    {
        "max397574/better-escape.nvim",
        lazy = false,
        opts = {
            mapping = { "jj", "jk", "kj" },
            keys = function()
                return vim.api.nvim_win_get_cursor(0)[2] > 1 and "<esc>l"
                    or "<esc>"
            end,
        },
    },
}
