---@class util.statusline
local M = {}

M.sections = {
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
        require("util.lazy").status(),
        require("util.lsp").status,
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
}

return M
