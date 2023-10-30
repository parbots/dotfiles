---@class picklevim.util.keymap
local M = {}

---@alias picklevim.keymap.mode string[]
---@alias picklevim.keymap.lhs string
---@alias picklevim.keymap.rhs string | fun()
---@alias picklevim.keymap.opts {desc: string}

---@class picklevim.keymap
---@field[1] picklevim.keymap.mode
---@field[2] picklevim.keymap.lhs
---@field[3] picklevim.keymap.rhs
---@field[4] picklevim.keymap.opts

---@param mode picklevim.keymap.mode
---@param lhs picklevim.keymap.lhs
---@param rhs picklevim.keymap.rhs
---@param opts picklevim.keymap.opts
M.set = function(mode, lhs, rhs, opts)
    vim.keymap.set(mode, lhs, rhs, opts)
end

---@param keymaps picklevim.keymap[]
---@param opts table?
M.map = function(keymaps, opts)
    opts = opts or {}

    for _, keymap in ipairs(keymaps) do
        keymap[4] = vim.tbl_deep_extend("force", opts, keymap[4] or {})

        M.set(keymap[1], keymap[2], keymap[3], keymap[4])
    end
end

return M
