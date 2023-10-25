---@class util.mason
local M = {}

M.refresh_on_success = function()
    local refresh = function()
        require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
        })
    end

    require("mason-registry"):on("package:install:success", function()
        vim.defer_fn(refresh, 100)
    end)
end

M.ensure_installed = function()
    local mason_registry = require("mason-registry")

    local install_packages = function()
        local ensure_installed = require("lsp.mason").ensure_installed

        for _, name in ipairs(ensure_installed) do
            local mason_package = mason_registry.get_package(name)

            if not mason_package:is_installed() then
                mason_package:install()
            end
        end
    end

    if mason_registry.refresh then
        mason_registry.refresh(install_packages())
    else
        install_packages()
    end
end

return M
