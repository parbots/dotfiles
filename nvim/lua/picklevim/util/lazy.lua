---@class picklevim.util.lazy: LazyUtilCore
local M = {}

local LazyUtil = require("lazy.core.util")
setmetatable(M, {
    __index = function(_, k)
        if LazyUtil[k] then
            return LazyUtil[k]
        end
    end,
})

return M
