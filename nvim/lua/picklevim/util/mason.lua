---@class picklevim.util.mason
local M = {}

local refresh = function()
    require("lazy.core.handler.event").trigger({
        event = "FileType",
        buf = vim.api.nvim_get_current_buf(),
    })
end

M.refresh_on_success = function()
    require("mason-registry"):on("package:install:success", function()
        vim.defer_fn(refresh, 100)
    end)
end

local install_packages = function(mason_registry)
    local ensure_installed = require("picklevim.lsp.mason").ensure_installed

    for _, name in ipairs(ensure_installed) do
        local mason_package = mason_registry.get_package(name)

        if not mason_package:is_installed() then
            mason_package:install()
        end
    end
end

M.ensure_installed = function()
    local mason_registry = require("mason-registry")

    if mason_registry.refresh then
        mason_registry.refresh(install_packages(mason_registry))
    else
        install_packages()
    end
end

return M
