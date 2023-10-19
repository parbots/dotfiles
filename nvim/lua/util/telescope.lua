local actions = require("telescope.actions")

local M = {}

M.custom_flex = function(picker, max_columns, max_lines, layout_config)
    local custom_layout = require("telescope.pickers.layout_strategies").flex(
        picker,
        max_columns,
        max_lines,
        layout_config
    )

    if custom_layout.prompt then
        custom_layout.prompt.title = false
    end

    if custom_layout.results then
        custom_layout.results.title = false
        custom_layout.results.line = custom_layout.results.line - 1
        custom_layout.results.height = custom_layout.results.height + 1
    end

    if custom_layout.preview then
        custom_layout.preview.title = false
        -- custom_layout.preview.height = custom_layout.preview.height - 1
    end

    return custom_layout
end

M.set_colors = function()
    local colors = require("catppuccin.palettes").get_palette() or {}

    local light = colors.mantle
    local dark = colors.crust

    local TelescopeColors = {
        TelescopeMatching = { fg = colors.mauve, bg = light },
        TelescopeSelection = {
            bg = light,
            bold = true,
        },
        TelescopeSelectionCaret = { bg = light },
        TelescopeMultiIcon = { bg = light },

        TelescopePromptTitle = { bg = dark },
        TelescopePromptPrefix = { bg = dark },
        TelescopePromptNormal = { bg = dark },
        TelescopePromptBorder = { bg = dark },

        TelescopePreviewTitle = { bg = dark },
        TelescopePreviewNormal = { bg = dark },
        TelescopePreviewBorder = { bg = dark },

        TelescopeResultsTitle = { bg = dark },
        TelescopeResultsNormal = { bg = dark },
        TelescopeResultsBorder = { bg = dark },
    }

    for hl, col in pairs(TelescopeColors) do
        vim.api.nvim_set_hl(0, hl, col)
    end
end

M.general_mappings = {
    ["qq"] = {
        actions.close,
        type = "action",
        opts = {
            desc = "Close Picker (Telescope)",
        },
    },
    ["<C-c>"] = {
        actions.close,
        type = "action",
        opts = {},
    },

    ["<Tab>"] = {
        actions.move_selection_next,
        type = "action",
        opts = {},
    },
    ["<S-Tab>"] = {
        actions.move_selection_previous,
        type = "action",
        opts = {},
    },

    ["<C-s>"] = {
        actions.select_vertical,
        type = "action",
        opts = {},
    },

    ["<C-h>"] = {
        actions.which_key,
        type = "action",
        opts = {},
    },
}

M.n_mappings = {
    ["j"] = {
        actions.move_selection_next,
        type = "action",
        opts = {},
    },
    ["k"] = {
        actions.move_selection_previous,
        type = "action",
        opts = {},
    },
}

M.i_mappings = {
    ["jj"] = {
        "<Esc>",
        type = "command",
        opts = {},
    },
    ["jk"] = {
        "<Esc>",
        type = "command",
        opts = {},
    },

    ["<M-j>"] = {
        actions.move_selection_next,
        type = "action",
        opts = {},
    },
    ["<M-k>"] = {
        actions.move_selection_previous,
        type = "action",
        opts = {},
    },
}

M.get_mappings = function()
    return {
        n = vim.tbl_deep_extend("force", M.general_mappings, M.n_mappings),
        i = vim.tbl_deep_extend("force", M.general_mappings, M.i_mappings),
    }
end

M.picker_opts = {
    live_grep = {
        max_results = 1000,
    },

    find_files = {
        find_command = {
            "fd",
            "--type",
            "file",
            "--hidden",
            "--no-ignore-vcs",
            "--size",
            "-50m",
        },
    },

    current_buffer_fuzzy_find = {
        skip_empty_lines = true,
    },

    builtin = {
        include_extensions = true,
    },

    quickfix = {
        trim_text = true,
    },

    loclist = {
        trim_text = true,
    },

    oldfiles = {
        cwd_only = true,
    },

    help_tags = {
        mappings = {
            n = {
                ["<CR>"] = {
                    actions.select_vertical,
                    type = "action",
                    opts = {},
                },
            },

            i = {
                ["<CR>"] = {
                    actions.select_vertical,
                    type = "action",
                    opts = {},
                },
            },
        },
    },

    buffers = {
        ignore_current_buffer = true,
        sort_mru = true,

        mappings = {
            n = {
                ["<C-x>"] = {
                    actions.delete_buffer,
                    type = "action",
                    opts = {},
                },
            },

            i = {
                ["<C-x>"] = {
                    actions.delete_buffer,
                    type = "action",
                    opts = {},
                },
            },
        },
    },

    colorscheme = {
        enable_preview = true,
    },

    jumplist = {
        trim_text = true,
    },

    lsp_references = {
        trim_text = true,
    },

    lsp_definitions = {
        jump_type = "vsplit",
        trim_text = true,
    },

    lsp_type_definitions = {
        jump_type = "vsplit",
        trim_text = true,
    },

    lsp_implementations = {
        jump_type = "vsplit",
        trim_text = true,
    },

    lsp_document_symbols = {
        show_line = true,
    },

    lsp_workspace_symbols = {
        show_line = true,
    },

    lsp_dynamic_workspace_symbols = {
        show_line = true,
    },
}

return M
