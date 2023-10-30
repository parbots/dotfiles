local Util = require("picklevim.util")

---@class picklevim.util.lualine
local M = {}

---@class picklevim.util.lualine.padding
---@field left number
---@field right number

M.padding = {
    ---@class picklevim.lualine.padding_left: picklevim.util.lualine.padding
    left = {
        left = 1,
        right = 0,
    },

    ---@class picklevim.lualine.padding_right: picklevim.util.lualine.padding
    right = {
        left = 0,
        right = 1,
    },
}

---@param opts? {padding?: picklevim.util.lualine.padding}
---@return table
M.lazy_status = function(opts)
    local lazy_status = require("lazy.status")

    return {
        lazy_status.updates,
        cond = lazy_status.has_updates,

        padding = opts and opts.padding or M.padding.right,
    }
end

---@param opts? {padding?: picklevim.util.lualine.padding}
---@return table
M.lsp_status = function(opts)
    return {
        Util.lsp.get_status,
        cond = Util.lsp.has_clients,

        icon = require("picklevim.config").icons.lsp.loaded,

        padding = opts and opts.padding or M.padding.right,
    }
end

---@param component any
---@param text string
---@param hl_group string
---@return string
M.highlight_text = function(component, text, hl_group)
    ---@type table<string, string>
    component.hl_cache = component.hl_cache or {}
    local hl = component.hl_cache[hl_group]
    if not hl then
        ---@type string
        hl = component:create_hl({
            fg = require("lualine.utils.utils").extract_highlight_colors(
                hl_group,
                "fg"
            ),
        }, "LV_" .. hl_group)

        component.hl_cache[hl_group] = hl
    end

    return component:format_hl(hl) .. text .. component:get_default_hl()
end

---@class picklevim.util.lualine.filepath
M.filepath = {
    ---@class picklevim.util.lualine.filepath.opts
    ---@field relative? "cwd" | "root"
    ---@field modified_hl? string
    ---@field padding? picklevim.util.lualine.padding
    defaults = {
        relative = "cwd",
        modified_hl = "Error",

        padding = M.padding.left,
    },

    ---@return boolean
    exists = function()
        return vim.fn.expand("%:p") ~= ""
    end,

    ---@param relative "cwd" | "root"
    ---@return string
    get = function(relative)
        local path = vim.fn.expand("%:p") ---@cast path string

        local cwd = Util.root.cwd()

        if relative == "cwd" and path:find(cwd, 1, true) == 1 then
            path = path:sub(#cwd + 2)
        else
            local root = Util.root.get({ normalize = true })
            path = path:sub(#root + 2)
        end

        return path
    end,

    ---@param component any
    ---@param path string
    ---@param modified_hl string
    ---@return string
    format = function(component, path, modified_hl)
        local parts = vim.split(path, "[\\/]")

        if vim.bo.modified then
            parts[#parts] =
                M.highlight_text(component, parts[#parts], modified_hl)
        end

        local separator = package.config:sub(1, 1)
        return table.concat(parts, separator)
    end,

    ---@param opts? picklevim.util.lualine.filepath.opts
    component = function(opts)
        opts = vim.tbl_deep_extend("force", M.filepath.defaults, opts or {})
            or M.filepath.defaults

        return {
            function(self)
                local path = M.filepath.get(opts.relative)
                return M.filepath.format(self, path, opts.modified_hl)
            end,
            cond = M.filepath.exists,

            padding = opts.padding,
        }
    end,
}

return M
