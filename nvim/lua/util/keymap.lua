---@class util.keymap
local M = {}

---@class picklevim.keymap
---@field[1] table
---@field[2] string
---@field[3] string|function
---@field[4] string
---@field[5] table?

---@alias picklevim.keymaps picklevim.keymap[]

---@param modes table
---@param lhs string
---@param rhs string|function
---@param desc string
---@param opts table?
M.set = function(modes, lhs, rhs, desc, opts)
    vim.keymap.set(
        modes,
        lhs,
        rhs,
        vim.tbl_deep_extend("force", opts or {}, { desc = desc })
    )
end

---@param keymaps picklevim.keymaps
---@param global_opts table?
M.map = function(keymaps, global_opts)
    for _, keymap in ipairs(keymaps) do
        local modes = keymap[1]
        local lhs = keymap[2]
        local rhs = keymap[3]
        local desc = keymap[4]
        local opts = keymap[5] or {}

        M.set(
            modes,
            lhs,
            rhs,
            desc,
            vim.tbl_deep_extend("force", global_opts or {}, opts)
        )
    end
end

return M
