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
    ["qq"] = "close",
    ["<C-c>"] = "close",

    ["<Tab>"] = "move_selection_next",
    ["<S-Tab>"] = "move_selection_previous",

    ["<C-s>"] = "select_vertical",
    ["<C-h>"] = "which_key",
}

M.n_mappings = vim.tbl_deep_extend("force", M.general_mappings, {
    ["j"] = "move_selection_next",
    ["k"] = "move_selection_previous",
})

M.i_mappings = vim.tbl_deep_extend("force", M.general_mappings, {
    ["jj"] = {
        "<Esc>",
        type = "command",
    },
    ["jk"] = {
        "<Esc>",
        type = "command",
    },

    ["<M-j>"] = "move_selection_next",
    ["<M-k>"] = "move_selection_previous",
})

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
                ["<cr>"] = "select_vertical",
            },

            i = {
                ["<cr>"] = "select_vertical",
            },
        },
    },

    buffers = {
        ignore_current_buffer = true,
        sort_mru = true,

        mappings = {
            n = {
                ["<C-x>"] = "delete_buffer",
            },

            i = {
                ["<C-x>"] = "delete_buffer",
            },
        },
    },

    colorscheme = {
        enable_preview = true,
    },

    keymaps = {
        modes = { "n", "i", "v" },
        show_plug = false,
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
