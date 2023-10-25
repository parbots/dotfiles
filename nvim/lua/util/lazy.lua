---@class util.lazy
local M = {}

M.init = function()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable",
            lazypath,
        })
    end

    vim.opt.rtp:prepend(lazypath)
end

---@param delay number
M.notify = function(delay)
    local notifications = {}

    local temp = function(...)
        table.insert(notifications, vim.F.pack_len(...))
    end

    local original = vim.notify
    vim.notify = temp

    local timer = vim.loop.new_timer() or {}
    local check = assert(vim.loop.new_check()) or {}

    local replay = function()
        timer:stop()
        check:stop()

        if vim.notify == temp then
            vim.notify = original
        end

        vim.schedule(function()
            for _, notification in ipairs(notifications) do
                vim.notify(vim.F.unpack_len(notification))
            end
        end)
    end

    check:start(function()
        if vim.notify ~= temp then
            replay()
        end
    end)

    timer:start(delay or 1000, 0, replay)
end

M.use_lazy_file_event = true
M.lazy_file_events = {
    "BufNewFile",
    "BufReadPre",
    "BufWritePre",
}

M.create_lazy_file_event = function()
    local Util = require("util")

    M.use_lazy_file_event = M.use_lazy_file_event and vim.fn.argc(-1) >= 0

    local lazy_event_handler = require("lazy.core.handler.event")

    if M.use_lazy_file_event then
        lazy_event_handler.mappings.LazyFile =
            { id = "LazyFile", event = "User", pattern = "LazyFile" }
    else
        lazy_event_handler.mappings.LazyFile = {
            id = "LazyFile",
            event = M.lazy_file_events,
        }
    end

    lazy_event_handler.mappings["User LazyFile"] =
        lazy_event_handler.mappings.LazyFile

    ---@type {event: string, buf: number, data?: any}[]
    local events = {}

    local function load()
        if #events == 0 then
            return
        end

        Util.del_augroup("lazy_file")

        ---@type table<string,string[]>
        local skips = {}
        for _, event in ipairs(events) do
            skips[event.event] = skips[event.event]
                or lazy_event_handler.get_augroups(event.event)
        end

        vim.api.nvim_exec_autocmds("User", { pattern = "LazyFile" })

        for _, event in ipairs(events) do
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

        vim.api.nvim_exec_autocmds("CursorMoved", {})

        events = {}
    end

    load = vim.schedule_wrap(load)

    vim.api.nvim_create_autocmd(M.lazy_file_events, {
        group = Util.augroup("lazy_file"),
        callback = function(event)
            table.insert(events, event)
            load()
        end,
    })
end

M.status = function()
    local lazy_status = require("lazy.status")

    return {
        lazy_status.updates,
        cond = lazy_status.has_updates,

        separator = "",
        padding = {
            left = 0,
            right = 1,
        },
    }
end

---@param plugin_name string
---@return table
M.get_opts = function(plugin_name)
    local plugin = require("lazy.core.config").plugins[plugin_name]
    if not plugin then
        return {}
    end

    local Plugin = require("lazy.core.plugin")
    return Plugin.values(plugin, "opts", false)
end

return M
