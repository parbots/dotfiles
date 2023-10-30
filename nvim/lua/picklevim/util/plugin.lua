local Util = require("picklevim.util")

---@class picklevim.util.plugin
local M = {}

M.use_lazyfile = true
M.lazyfile_events = {
    "BufNewFile",
    "BufReadPre",
    "BufWritePre",
}

M.setup_lazyfile = function()
    M.use_lazyfile = M.use_lazyfile and vim.fn.argc(-1) > 0

    local lazy_event_handler = require("lazy.core.handler.event")

    if M.use_lazyfile then
        lazy_event_handler.mappings.LazyFile = {
            id = "LazyFile",
            event = "User",
            pattern = "LazyFile",
        }
        lazy_event_handler["User LazyFile"] =
            lazy_event_handler.mappings.LazyFile
    else
        lazy_event_handler.mappings.LazyFile = {
            id = "LazyFile",
            event = M.lazyfile_events,
        }
        lazy_event_handler["User LazyFile"] =
            lazy_event_handler.mappings.LazyFile

        return
    end

    ---@type {event: string, buf: number, data?: any}[]
    local events = {}

    local done_loading = false
    local load = function()
        if #events == 0 or done_loading then
            return
        end

        done_loading = true

        Util.del_augroup("lazyfile")

        ---@type table<string, string[]>
        local skips = {}
        for _, event in ipairs(events) do
            skips[event.event] = skips[event.event]
                or lazy_event_handler.get_augroups(event.event)
        end

        vim.api.nvim_exec_autocmds(
            "User",
            { pattern = "LazyFile", modeline = false }
        )

        for _, event in ipairs(events) do
            if vim.api.nvim_buf_is_valid(event.buf) then
                lazy_event_handler.trigger({
                    event = event.event,
                    exclude = skips[event.event],
                    data = event.data,
                    buf = event.buf,
                })

                if vim.bo[event.buf].filetype then
                    lazy_event_handler.trigger({
                        event = "FileType",
                        buf = event.buf,
                    })
                end
            end
        end

        vim.api.nvim_exec_autocmds("CursorMoved", { modeline = false })

        events = {}
    end

    load = vim.schedule_wrap(load)

    Util.autocmd({
        group = "lazyfile",
        event = M.lazyfile_events,
        opts = {
            callback = function(event)
                table.insert(events, event)

                load()
            end,
        },
    })
end

---@param name string
---@return table
M.get_opts = function(name)
    local plugin = require("lazy.core.config").plugins[name]
    if not plugin then
        return {}
    end

    return require("lazy.core.plugin").values(plugin, "opts", false)
end

---@param name string
---@param fn fun(name: string)
M.on_load = function(name, fn)
    local lazy_config = require("lazy.core.config")
    if lazy_config.plugins[name] and lazy_config.plugins[name]._.loaded then
        fn(name)
    else
        Util.autocmd({
            group = "on_load_" .. name,
            event = "User",
            opts = {
                pattern = "LazyLoad",
                callback = function(event)
                    if event.data == name then
                        fn(name)

                        return true
                    end
                end,
            },
        })
    end
end

M.setup = function()
    M.setup_lazyfile()
end

return M
