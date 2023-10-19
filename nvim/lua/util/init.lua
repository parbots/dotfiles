local M = {}

setmetatable(M, {
    __index = function(t, k)
        t[k] = require("util." .. k)
        return t[k]
    end,
})

M.lazy_init = function()
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

M.lazy_notify = function(delay)
    local notifications = {}

    local temp = function(...)
        table.insert(notifications, vim.F.pack_len(...))
    end

    local original = vim.notify
    vim.notify = temp

    local timer = vim.loop.new_timer()
    local check = assert(vim.loop.new_check())

    local replay = function()
        if timer then
            timer:stop()
        end
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

    if timer then
        timer:start(delay or 500, 0, replay)
    end
end

M.use_lazy_file = true
M.lazy_file_events = {
    "BufReadPost",
    "BufNewFile",
    "BufWritePre",
}
M.lazy_file = function()
    M.use_lazy_file = M.use_lazy_file and vim.fn.argc(-1) > 0

    local lazy_event_handler = require("lazy.core.handler.event")

    if M.use_lazy_file then
        lazy_event_handler.mappings.LazyFile =
            { id = "LazyFile", event = "User", pattern = "LazyFile" }
    else
        lazy_event_handler.mappings.LazyFile = {
            id = "LazyFile",
            event = { "BufReadPost", "BufNewFile", "BufWritePre" },
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

        vim.api.nvim_del_augroup_by_name("lazy_file")

        ---@type table<string,string[]>
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

        vim.api.nvim_exec_autocmds("CursorMoved", { modeline = false })

        events = {}
    end

    load = vim.schedule_wrap(load)

    vim.api.nvim_create_autocmd(M.lazy_file_events, {
        group = vim.api.nvim_create_augroup("lazy_file", { clear = true }),
        callback = function(event)
            table.insert(events, event)
            load()
        end,
    })
end

M.lazy_status = function()
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

M.opts = function(name)
    local plugin = require("lazy.core.config").plugins[name]
    if not plugin then
        return {}
    end

    local Plugin = require("lazy.core.plugin")
    return Plugin.values(plugin, "opts", false)
end

-- Helper function to create multiple keymaps
M.map = function(keymaps, global_opts)
    for _, keymap in ipairs(keymaps) do
        local modes = keymap[1]
        local lhs = keymap[2]
        local rhs = keymap[3]

        local opts = vim.tbl_deep_extend(
            "error",
            global_opts or {},
            keymap[5] or {},
            { desc = keymap[4] }
        )

        vim.keymap.set(modes, lhs, rhs, opts)
    end
end

return M