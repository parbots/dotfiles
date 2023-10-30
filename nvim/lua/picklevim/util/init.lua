---@class picklevim.util
---@field keymap picklevim.util.keymap
---@field lazy picklevim.util.lazy
---@field lsp picklevim.util.lsp
---@field mason picklevim.util.mason
---@field plugin picklevim.util.plugin
---@field root picklevim.util.root
---@field telescope picklevim.util.telescope
---@field format picklevim.util.format
---@field whichkey picklevim.util.whichkey
local M = {}

setmetatable(M, {
    __index = function(t, k)
        t[k] = require("picklevim.util." .. k)
        return t[k]
    end,
})

---@return boolean
M.is_win = function()
    return vim.loop.os_uname().sysname:find("Windows") ~= nil
end

---@param name string
---@param clear? boolean
---@return number
M.augroup = function(name, clear)
    return vim.api.nvim_create_augroup(
        "picklevim_" .. name,
        { clear = clear or true }
    )
end

---@param name string
M.del_augroup = function(name)
    vim.api.nvim_del_augroup_by_name("picklevim_" .. name)
end

---@param autocmd {group: string, clear?: boolean, event: string | string[], opts?: table}
---@return number
M.autocmd = function(autocmd)
    autocmd.opts = autocmd.opts or {}
    autocmd.opts.group = autocmd.opts.group
        or M.augroup(autocmd.group, autocmd.clear)

    return vim.api.nvim_create_autocmd(autocmd.event, autocmd.opts)
end

---@param name string
---@param command any
---@param desc string
M.usercmd = function(name, command, desc)
    vim.api.nvim_create_user_command("Pickle" .. name, command, { desc = desc })
end

---@param delay? number
M.delay_notify = function(delay)
    local notifications = {}

    local temp_notify = function(...)
        table.insert(notifications, vim.F.pack_len(...))
    end

    local default_notify = vim.notify
    vim.notify = temp_notify

    local timer = vim.loop.new_timer() or {}
    local check = assert(vim.loop.new_check()) or {}

    local notify = function()
        vim.schedule(function()
            for _, notification in ipairs(notifications) do
                vim.notify(vim.F.unpack_len(notification))
            end
        end)
    end

    -- Wait til vim.notify has been replaced
    check:start(function()
        if vim.notify ~= temp_notify then
            check:stop()
            timer:stop()

            notify()
        end
    end)

    -- Or if it took too long, then something went wrong
    timer:start(delay or 1000, 0, function()
        timer:stop()
        check:stop()

        if vim.notify == temp_notify then
            vim.notify = default_notify
        end

        notify()
    end)
end

---@param fn fun()
M.on_verylazy = function(fn)
    M.autocmd({
        group = "on_verylazy",
        event = "User",
        opts = {
            pattern = "VeryLazy",
            callback = function()
                fn()
            end,
        },
    })
end

return M
