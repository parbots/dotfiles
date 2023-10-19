return {

    {
        "folke/which-key.nvim",
        keys = { { "<leader>" } },
        opts = {
            window = {
                border = "none",
                winblend = 10,
                margin = { 0, 0, 1, 0 },
                padding = { 1, 1, 1, 1 },
            },

            layout = {
                width = { min = 1, max = 100 },
                height = { min = 1, max = 25 },
                spacing = 1,
                align = "center",
            },
        },
        config = function(_, opts)
            local wk = require("which-key")

            wk.setup(opts)

            wk.register({
                ["c"] = {
                    name = "+change",
                },

                ["d"] = {
                    name = "+delete",
                },

                ["<leader>"] = {
                    name = "+leader",

                    b = { name = "+buffer" },
                    d = { name = "+delete" },
                    f = { name = "+find/file" },
                    fl = { name = "+lsp" },
                    g = { name = "+git" },
                    l = { name = "+lsp" },
                    o = { name = "+open" },
                    s = { name = "+search/sort" },
                    sn = { name = "+noice" },
                    t = { name = "+tab/trouble" },
                    tl = { name = "+lsp" },
                    T = { name = "+treesitter" },
                    w = { name = "+window/write" },
                },
            })
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
                "<CMD> Spectre <CR>",
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
                "<CMD> UndotreeToggle <CR>",
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
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {},
    },

    {
        "windwp/nvim-autopairs",
        event = { "LazyFile" },
        opts = {
            check_ts = true,
            fast_wrap = {},
        },
    },

    {
        "numToStr/Comment.nvim",
        event = { "LazyFile" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {},
    },

    {
        "max397574/better-escape.nvim",
        lazy = false,
        opts = {
            mapping = { "jj", "jk", "kj" },
        },
    },
}
