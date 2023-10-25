---@class util.lsp
local M = {}

---@return boolean
M.has_clients = function()
    return vim.lsp.get_clients({
        bufnr = vim.api.nvim_get_current_buf(),
    }) ~= nil
end

---@return lsp.Client[]
M.get_curr_clients = function()
    return vim.lsp.get_clients({
        bufnr = vim.api.nvim_get_current_buf(),
    })
end

---@param buffer integer
---@return lsp.Client[]
M.get_buf_clients = function(buffer)
    return vim.lsp.get_clients({
        bufnr = buffer,
    })
end

---@class util.lsp.status
M.status = {
    ---@return string
    function()
        local clients = ""

        for client_idx, client in ipairs(M.get_curr_clients()) do
            if client_idx == 1 then
                clients = client.name
            else
                clients = clients .. ", " .. client.name
            end
        end

        return clients
    end,

    cond = M.has_clients,

    separator = "",
    padding = {
        left = 0,
        right = 1,
    },
}

---@param on_attach fun(client: lsp.Client|nil, buffer: integer)
M.on_attach = function(on_attach)
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
            local client = vim.lsp.get_client_by_id(event.data.client_id)
            local buffer = event.buf

            on_attach(client, buffer)
        end,
    })
end

M.show_hover = function()
    local filetype = vim.bo.filetype

    if vim.tbl_contains({ "vim", "help" }, filetype) then
        vim.cmd("h " .. vim.fn.expand("<cword>"))
    elseif vim.tbl_contains({ "man" }, filetype) then
        vim.cmd("Man " .. vim.fn.expand("<cword>"))
    else
        vim.lsp.buf.hover()
    end
end

---@class util.lsp.server
M.server = {
    ---@param buffer integer
    ---@param method string
    supports_method = function(buffer, method)
        for _, client in pairs(M.get_buf_clients(buffer)) do
            if client.supports_method(method) then
                return true
            end
        end

        return false
    end,
}

---@class util.lsp.keymaps
M.keymaps = {
    ---@type lsp.keymap[]|nil
    keys = nil,

    ---@return lsp.keymap[]|nil
    get_keys = function()
        if M.keymaps.keys then
            return M.keymaps.keys
        end

        M.keymaps.keys = require("lsp.keymaps")

        return M.keymaps.keys
    end,

    ---@param _ lsp.Client|nil
    ---@param buffer integer
    on_attach = function(_, buffer)
        local keymaps = M.keymaps.get_keys() or {}
        local servers = require("lsp.servers")
        local clients = M.get_buf_clients(buffer)

        for _, client in pairs(clients) do
            vim.list_extend(
                keymaps,
                servers[client.name] and servers[client.name].keymaps or {}
            )
        end

        local keymap_util = require("util.keymap")
        for _, keymap in ipairs(keymaps) do
            if M.server.supports_method(buffer, keymap.method) then
                keymap_util.set(keymap[1], keymap[2], keymap[3], keymap[4], {
                    buffer = buffer,
                })
            end
        end
    end,

    setup = function()
        M.on_attach(M.keymaps.on_attach)

        local register_capability =
            vim.lsp.handlers["client/registerCapability"]
        vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
            local client = vim.lsp.get_client_by_id(ctx.client_id)
            local buffer = vim.api.nvim_get_current_buf()
            M.keymaps.on_attach(client, buffer)

            return register_capability(err, res, ctx)
        end
    end,
}

---@class util.lsp.inlay_hints
M.inlay_hints = {
    ---@param enabled boolean
    setup = function(enabled)
        M.on_attach(function(client, buffer)
            if client and client.supports_method("textDocument/inlayHint") then
                vim.lsp.inlay_hint(buffer, enabled)
            end
        end)
    end,
}

M.diagnostics = {
    ---@param config table
    setup = function(config)
        local icons = require("config.icons").diagnostics

        for name, icon in pairs(icons) do
            name = "DiagnosticSign" .. name

            vim.fn.sign_define(name, {
                text = icon,
                texthl = name,
                numhl = "",
            })
        end

        if config.virtual_text.prefix == "icons" then
            config.virtual_text.prefix = function(diagnostic)
                for d, icon in pairs(icons) do
                    if
                        diagnostic.severity
                        == vim.diagnostic.severity[d:upper()]
                    then
                        return icon
                    end
                end
            end
        else
            config.virtual_text.prefix = "●"
        end

        vim.diagnostic.config(vim.deepcopy(config))
    end,
}

---@class util.lsp.capabilities
M.capabilities = {
    ---@param capabilities lsp.ClientCapabilities
    ---@return lsp.ClientCapabilities
    setup = function(capabilities)
        local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

        return vim.tbl_deep_extend(
            "force",
            vim.lsp.protocol.make_client_capabilities() or {},
            has_cmp and cmp_nvim_lsp.default_capabilities() or {},
            capabilities or {}
        ) or {}
    end,
}

M.servers = {
    ---@param capabilities lsp.ClientCapabilities
    setup = function(capabilities)
        local lspconfig = require("lspconfig")
        local servers = require("lsp.servers")
        capabilities = M.capabilities.setup(capabilities)

        local setup_server = function(server)
            local server_opts = {
                capabilities = vim.deepcopy(capabilities),
            }

            if servers[server] then
                server_opts = vim.tbl_deep_extend(
                    "force",
                    server_opts,
                    servers[server].opts or {}
                ) or {}

                if servers[server].setup then
                    if servers[server].setup(server, server_opts) then
                        return
                    end
                end
            end

            lspconfig[server].setup(server_opts)
        end

        local have_mason_lsp, mason_lsp = pcall(require, "mason-lspconfig")
        if have_mason_lsp then
            local mason_servers = vim.tbl_keys(
                require("mason-lspconfig.mappings.server").lspconfig_to_package
            )

            local ensure_installed = {}
            for server, server_config in pairs(servers) do
                if
                    server_config.mason and server_config.mason == false
                    or not vim.tbl_contains(mason_servers, server)
                then
                    setup_server(server)
                else
                    ensure_installed[#ensure_installed + 1] = server
                end
            end

            mason_lsp.setup({
                ensure_installed = ensure_installed,
                handlers = { setup_server },
            })
        else
            for server, _ in pairs(servers) do
                setup_server(server)
            end
        end
    end,
}

return M
