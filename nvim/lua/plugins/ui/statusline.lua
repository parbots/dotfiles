return {

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

            local statusline_util = require("util.statusline")
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

                sections = statusline_util.sections,
            }
        end,
        config = true,
    },
}
