---@class config.lazy
local M = {}

local setup_lazypath = function()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable",
            lazypath,
        })
    end

    vim.opt.rtp:prepend(lazypath)
end

---@type LazyConfig
local config = {
    spec = {
        { import = "picklevim.plugins" },
        { import = "picklevim.plugins.ui" },
        { import = "picklevim.plugins.lsp" },
        { import = "picklevim.plugins.completion" },

        -- { import = "plugins" },
    },

    defaults = {
        lazy = true,
        version = false,
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
        title = "Lazy.nvim",
        title_pos = "left",

        pills = true,

        icons = {
            cmd = " ",
            config = "",
            event = "",
            ft = " ",
            init = " ",
            import = "󰋺 ",
            keys = "󰌆 ",
            lazy = "󰒲 ",
            loaded = "●",
            not_loaded = "○",
            plugin = "󰏗 ",
            runtime = " ",
            require = " ",
            source = " ",
            start = "󰼛",
            task = " ",
            list = {
                "●",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
            },
        },
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
}

---@param opts LazyConfig
M.setup = function(opts)
    opts = vim.tbl_deep_extend("force", config, opts or {}) or {}

    setup_lazypath()

    require("lazy").setup(opts)
end

return M
