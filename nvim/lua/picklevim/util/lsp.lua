---@class picklevim.util.lsp
local M = {}

---@return string
M.get_status = function()
    local client_info = ""

    for client_idx, client in ipairs(M.clients.get_curr()) do
        if client_idx == 1 then
            client_info = client.name
        else
            client_info = client_info .. ", " .. client.name
        end
    end

    return client_info
end

---@return boolean
M.has_clients = function()
    return vim.lsp.get_clients({
        bufnr = vim.api.nvim_get_current_buf(),
    }) ~= nil
end

M.hover = function()
    local filetype = vim.bo.filetype

    if vim.tbl_contains({ "vim", "help" }, filetype) then
        vim.cmd("h " .. vim.fn.expand("<cword>"))
    elseif vim.tbl_contains({ "man" }, filetype) then
        vim.cmd("Man " .. vim.fn.expand("<cword>"))
    else
        vim.lsp.buf.hover()
    end
end

---@class picklevim.util.lsp.clients
M.clients = {
    ---@return lsp.Client[]
    get_curr = function()
        return vim.lsp.get_clients({
            bufnr = vim.api.nvim_get_current_buf(),
        })
    end,

    ---@param buffer number
    ---@return lsp.Client[]
    get_buf = function(buffer)
        return vim.lsp.get_clients({
            bufnr = buffer,
        })
    end,

    ---@param id number
    ---@return lsp.Client|nil
    get_id = function(id)
        return vim.lsp.get_client_by_id(id)
    end,

    ---@param buffer number
    ---@param method string
    supports_method = function(buffer, method)
        for _, client in pairs(M.clients.get_buf(buffer)) do
            if client.supports_method(method) then
                return true
            end
        end

        return false
    end,
}

---@class picklevim.util.lsp.keymaps
M.keymaps = {
    ---@type picklevim.lsp.keymaps | nil
    keymaps = nil,

    ---@return picklevim.lsp.keymaps
    get = function()
        if M.keymaps.keymaps then
            return M.keymaps.keymaps
        end

        M.keymaps.keymaps = require("picklevim.lsp.keymaps")

        return M.keymaps.keymaps
    end,

    ---@param _ lsp.Client|nil
    ---@param buffer number
    on_attach = function(_, buffer)
        local keymaps = M.keymaps.get()
        local servers = M.servers.get()
        local clients = M.clients.get_buf(buffer)

        for _, client in ipairs(clients) do
            vim.list_extend(
                keymaps,
                servers[client.name] and servers[client.name].keymaps or {}
            )
        end

        local keymap_util = require("picklevim.util.keymap")
        for _, keymap in pairs(keymaps) do
            if M.clients.supports_method(buffer, keymap.method) then
                keymap_util.map(
                    { { keymap[1], keymap[2], keymap[3], keymap[4] } },
                    { buffer = buffer }
                )
            end
        end
    end,

    setup = function()
        M.servers.on_attach(M.keymaps.on_attach)

        local register_capability =
            vim.lsp.handlers["client/registerCapability"]
        vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
            local client = M.clients.get_id(ctx.client_id)
            local buffer = vim.api.nvim_get_current_buf()
            M.keymaps.on_attach(client, buffer)

            return register_capability(err, res, ctx)
        end
    end,
}

---@class picklevim.util.lsp.inlay_hints
M.inlay_hints = {
    toggle = function()
        vim.lsp.inlay_hint(0, nil)
    end,

    ---@param client lsp.Client|nil
    ---@param buffer number
    ---@param enabled boolean
    on_attach = function(client, buffer, enabled)
        if client and client.supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint(buffer, enabled)
        end
    end,

    ---@param enabled boolean?
    setup = function(enabled)
        M.servers.on_attach(function(client, buffer)
            M.inlay_hints.on_attach(client, buffer, enabled or false)
        end)
    end,
}

---@class picklevim.util.lsp.diagnostics
M.diagnostics = {
    ---@class picklevim.lsp.diagnostics.virtual_text
    ---@field prefix "icons" | "●" | fun(diagnostic: lsp.Diagnostic): string | nil
    ---@field spacing number
    ---@field source string

    ---@class picklevim.lsp.diagnostics.opts
    ---@field underline boolean
    ---@field update_in_insert boolean
    ---@field severity_sort boolean
    ---@field virtual_text picklevim.lsp.diagnostics.virtual_text
    default_config = {
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        virtual_text = {
            prefix = "icons",
            spacing = 4,
            source = "if_many",
        },
    },

    ---@param config picklevim.lsp.diagnostics.opts?
    setup = function(config)
        config = config or M.diagnostics.default_config

        local icons = require("picklevim.config").icons.diagnostics

        for name, icon in pairs(icons) do
            name = "DiagnosticSign" .. name

            vim.fn.sign_define(name, {
                text = icon,
                texthl = name,
                numhl = "",
            })
        end

        if config.virtual_text.prefix == "icons" then
            ---@param diagnostic Diagnostic
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

---@class picklevim.util.lsp.capabilities
M.capabilities = {
    ---@param capabilities lsp.ClientCapabilities?
    ---@return lsp.ClientCapabilities
    setup = function(capabilities)
        local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()

        local cmp_capabilities = {}
        local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
        if has_cmp then
            cmp_capabilities = cmp_nvim_lsp.default_capabilities()
        end

        local custom_capabilities = capabilities or {}

        return vim.tbl_deep_extend(
            "force",
            lsp_capabilities,
            cmp_capabilities,
            custom_capabilities
        ) or lsp_capabilities
    end,
}

---@class picklevim.util.lsp.servers
M.servers = {
    ---@return picklevim.lsp.servers
    get = function()
        return require("picklevim.lsp.servers")
    end,

    ---@param on_attach fun(client: lsp.Client|nil, buffer: number)
    on_attach = function(on_attach)
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(event)
                local client = M.clients.get_id(event.data.client_id)
                local buffer = event.buf

                on_attach(client, buffer)
            end,
        })
    end,

    ---@param capabilities lsp.ClientCapabilities?
    setup = function(capabilities)
        local lspconfig = require("lspconfig")
        local servers = M.servers.get()
        capabilities = M.capabilities.setup(capabilities)

        ---@param server string
        local setup_server = function(server)
            local server_opts = {
                capabilities = vim.deepcopy(capabilities),
            }

            if servers[server] then
                server_opts = vim.tbl_deep_extend(
                    "force",
                    server_opts,
                    servers[server].opts or {}
                ) or server_opts

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
            ---@type string[]
            local mason_servers = vim.tbl_keys(
                require("mason-lspconfig.mappings.server").lspconfig_to_package
            )

            ---@type string[]
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

---@class picklevim.lsp.opts
---@field inlay_hints boolean?
---@field diagnostics picklevim.lsp.diagnostics.opts?
---@field capabilities lsp.ClientCapabilities?

---@param opts picklevim.lsp.opts?
M.setup = function(opts)
    M.keymaps.setup()
    M.inlay_hints.setup(opts and opts.inlay_hints)
    M.diagnostics.setup(opts and opts.diagnostics)
    M.servers.setup(opts and opts.capabilities)
end

return M
