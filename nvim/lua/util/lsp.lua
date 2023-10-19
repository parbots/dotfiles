local M = {}

M.has_active_clients = function()
    return vim.lsp.get_clients({
        bufnr = vim.api.nvim_get_current_buf(),
    }) ~= nil
end

M.get_active_clients = function()
    return vim.lsp.get_clients({
        bufnr = vim.api.nvim_get_current_buf(),
    })
end

M.active_clients = {
    function()
        local active_clients = ""

        for client_idx, client in ipairs(M.get_active_clients()) do
            if client_idx == 1 then
                active_clients = client.name
            else
                active_clients = active_clients .. ", " .. client.name
            end
        end

        return active_clients
    end,
    cond = M.has_active_clients,

    separator = "",
    padding = {
        left = 0,
        right = 1,
    },
}

M.get_clients = function(opts)
    local ret = {}

    if vim.lsp.get_clients then
        ret = vim.lsp.get_clients(opts)
    else
        ---@diagnostic disable-next-line: deprecated
        ret = vim.lsp.get_active_clients(opts)

        if opts and opts.method then
            ret = vim.tbl_filter(function(client)
                return client.supports_method(
                    opts.method,
                    { bufnr = opts.bufnr }
                )
            end, ret)
        end
    end

    return opts and opts.filter and vim.tbl_filter(opts.filter, ret) or ret
end

M.get_capabilities = function()
    local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities() or {}
    )

    return capabilities
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

M.on_attach = function(on_attach)
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
            local buffer = event.buf
            local client = vim.lsp.get_client_by_id(event.data.client_id)

            on_attach(client, buffer)
        end,
    })
end

return M
