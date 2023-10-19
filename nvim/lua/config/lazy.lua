local Util = require("util")

Util.lazy_init()

Util.lazy_file()

return function(opts)
    opts = vim.tbl_deep_extend("force", {
        defaults = {
            lazy = true,
            version = false,
        },

        spec = {
            { import = "plugins" },
        },

        git = {
            log = { "-10" },
            timeout = 120,
        },

        install = {
            missing = true,
            colorsceme = { "catppuccin" },
        },

        ui = {
            size = {
                width = 0.8,
                height = 0.8,
            },

            wrap = true,
            border = "solid",
            pills = true,
        },

        throttle = 10,

        diff = {
            cmd = "diffview.nvim",
        },

        checker = {
            enabled = true,
            notify = true,
            frequency = 3600,
        },

        change_detection = {
            enabled = true,
            notify = false,
        },

        performance = {
            cache = {
                enabled = true,
            },

            reset_packpath = true,

            rtp = {
                reset = true,
                disabled_plugins = {
                    "editorconfig",
                    "gzip",
                    -- "matchit",
                    -- "matchparen",
                    "netrwPlugin",
                    "rplugin",
                    "tarPlugin",
                    "tohtml",
                    "tutor",
                    "zipPlugin",
                },
            },
        },

        readme = {
            enabled = true,
            skip_if_doc_exists = true,
        },

        profiling = {
            loader = false,
            require = false,
        },
    }, opts or {})

    -- Load Lazy.nvim and plugins
    require("lazy").setup(opts)

    Util.lazy_notify(1000)
end
