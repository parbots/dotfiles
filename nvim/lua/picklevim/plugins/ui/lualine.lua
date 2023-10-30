return {
    {
        "nvim-lualine/lualine.nvim",
        event = { "LazyFile" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        init = function()
            vim.g.lualine_laststatus = vim.o.laststatus

            if vim.fn.argc(-1) > 0 then
                -- Set an empty statusline until lualine loads
                vim.o.statusline = " "
            else
                -- Hide the statusline on the starter page
                vim.o.laststatus = 0
            end
        end,
        opts = function()
            local lualine_require = require("lualine_require")
            lualine_require.require = require

            vim.o.laststatus = vim.g.lualine_laststatus

            local icons = require("picklevim.config").icons
            local lualine_util = require("picklevim.util.lualine")
            return {
                options = {
                    theme = "catppuccin",

                    component_separators = {
                        left = "",
                        right = "",
                    },
                    section_separators = {
                        left = "",
                        right = "",
                    },

                    always_divide_middle = true,

                    globalstatus = true,

                    disabled_filetypes = {
                        "alpha",
                    },
                },

                extensions = {
                    "lazy",
                    "man",
                    "mason",
                    "toggleterm",
                    "trouble",
                },

                sections = {
                    -- Left
                    lualine_a = {
                        {
                            "mode",

                            padding = lualine_util.padding.left,
                        },
                    },
                    lualine_b = {
                        {
                            "branch",

                            icon = icons.git.branch,

                            padding = lualine_util.padding.left,
                        },
                        {
                            "diff",

                            symbols = {
                                added = icons.git.added,
                                modified = icons.git.modified,
                                removed = icons.git.removed,
                            },

                            padding = lualine_util.padding.left,
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

                            symbols = {
                                error = icons.diagnostics.Error,
                                warn = icons.diagnostics.Warn,
                                info = icons.diagnostics.Info,
                                hint = icons.diagnostics.Hint,
                            },

                            padding = lualine_util.padding.left,
                        },
                        lualine_util.filepath.component({
                            padding = lualine_util.padding.left,
                        }),
                    },

                    -- Right
                    lualine_x = {
                        lualine_util.lazy_status({
                            padding = lualine_util.padding.right,
                        }),
                        lualine_util.lsp_status({
                            padding = lualine_util.padding.right,
                        }),
                    },
                    lualine_y = {
                        {
                            "filetype",

                            colors = true,
                            icon_only = false,

                            padding = lualine_util.padding.right,
                        },
                    },
                    lualine_z = {
                        {
                            "progress",

                            padding = lualine_util.padding.right,
                        },
                        {
                            "location",

                            padding = lualine_util.padding.right,
                        },
                    },
                },
            }
        end,
        config = true,
    },
}
