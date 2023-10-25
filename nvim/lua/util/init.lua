---@class util
---@field dashboard util.dashboard
---@field keymap util.keymap
---@field lazy util.lazy
---@field lsp util.lsp
---@field mason util.mason
---@field notifications util.notifications
---@field statusline util.statusline
---@field telescope util.telescope
---@field whichkey util.whichkey
local M = {}

setmetatable(M, {
    __index = function(t, k)
        t[k] = require("util." .. k)
        return t[k]
    end,
})

---@param name string
---@return number
M.augroup = function(name)
    return vim.api.nvim_create_augroup("picklevim_" .. name, { clear = true })
end

---@param name string
M.del_augroup = function(name)
    vim.api.nvim_del_augroup_by_name("picklevim_" .. name)
end

return M
