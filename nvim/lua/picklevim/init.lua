---@class picklevim
local M = {}

---@param opts picklevim.config.opts?
M.setup = function(opts)
    require("picklevim.config").setup(opts)
end

return M
