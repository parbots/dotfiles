local Util = require("picklevim.util")

---@class picklevim.util.telescope
local M = {}

local custom_flex = function(picker, max_columns, max_lines, layout_config)
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
    end

    return custom_layout
end

M.setup_layout_strategies = function()
    require("telescope.pickers.layout_strategies").custom_flex = custom_flex
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

---@class picklevim.telescope.opts
---@field cwd? string | boolean
---@field show_untracked? boolean

---@param builtin string
---@param opts? picklevim.telescope.opts
M.open = function(builtin, opts)
    local params = { builtin = builtin, opts = opts }
    return function()
        builtin = params.builtin
        opts = params.opts

        opts = vim.tbl_deep_extend("force", { cwd = Util.root() }, opts or {})
            or {}

        if builtin == "files" then
            if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.git") then
                opts.show_untracked = true
                builtin = "git_files"
            else
                builtin = "find_files"
            end
        end

        if opts.cwd and opts.cwd ~= vim.loop.cwd then
            opts.attach_mappings = function(_, map)
                map("i", "<a-c>", function()
                    local action_state = require("telescope.actions.state")
                    local line = action_state.get_current_line()

                    M.open(
                        params.builtin,
                        vim.tbl_deep_extend("force", params.opts or {}, {
                            cwd = false,
                            default_text = line,
                        })
                    )()
                end)

                return true
            end
        end

        require("telescope.builtin")[builtin](opts)
    end
end

return M
