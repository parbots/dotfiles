local Util = require("picklevim.util")

---@class picklevim.util.format
local M = setmetatable({}, {
    __call = function(m, ...)
        return m.format(...)
    end,
})

---@class picklevim.util.format.formatter
---@field name string
---@field primary? boolean
---@field priority number
---@field sources fun(buffer: number): string[]
---@field format fun(buffer: number)

---@alias picklevim.util.format.formatters picklevim.util.format.formatter[]

---@type picklevim.util.format.formatters
M.formatters = {}

---@param formatter picklevim.util.format.formatter
M.register = function(formatter)
    M.formatters[#M.formatters + 1] = formatter

    table.sort(M.formatters, function(a, b)
        return a.priority > b.priority
    end)
end

M.formatexpr = function()
    return require("conform").formatexpr()
end

---@param buffer number
---@return (picklevim.util.format.formatter | {active: boolean, resolved: string[]})[]
M.resolve = function(buffer)
    buffer = buffer or vim.api.nvim_get_current_buf()
    local have_primary = false

    ---@param formatter picklevim.util.format.formatter
    return vim.tbl_map(function(formatter)
        local sources = formatter.sources(buffer)
        local active = #sources > 0
            and (not formatter.primary or not have_primary)

        have_primary = have_primary or (active and formatter.primary) or false

        return setmetatable({
            active = active,
            resolved = sources,
        }, { __index = formatter })
    end, M.formatters)
end

---@param buffer? number
function M.info(buffer)
    buffer = buffer or vim.api.nvim_get_current_buf()

    local global_autoformat = vim.g.autoformat == nil or vim.g.autoformat
    local buffer_autoformat = vim.b[buffer].autoformat

    local enabled = M.enabled(buffer)
    local lines = {
        "# Status",
        ("- [%s] global **%s**"):format(
            global_autoformat and "x" or " ",
            global_autoformat and "enabled" or "disabled"
        ),
        ("- [%s] buffer **%s**"):format(
            enabled and "x" or " ",
            buffer_autoformat == nil and "inherit"
                or buffer_autoformat and "enabled"
                or "disabled"
        ),
    }

    local have = false
    for _, formatter in ipairs(M.resolve(buffer)) do
        if #formatter.resolved > 0 then
            have = true
            lines[#lines + 1] = "\n# "
                .. formatter.name
                .. (formatter.active and " ***(active)***" or "")
            for _, line in ipairs(formatter.resolved) do
                lines[#lines + 1] = ("- [%s] **%s**"):format(
                    formatter.active and "x" or " ",
                    line
                )
            end
        end
    end

    if not have then
        lines[#lines + 1] = "\n***No formatters available for this buffer.***"
    end

    Util.lazy[enabled and "info" or "warn"](table.concat(lines, "\n"), {
        title = "PickleFormat ("
            .. (enabled and "enabled" or "disabled")
            .. ")",
    })
end

---@param buffer? number
---@return string | boolean
function M.enabled(buffer)
    buffer = (buffer == nil or buffer == 0) and vim.api.nvim_get_current_buf()
        or buffer

    local global_autoformat = vim.g.autoformat == nil or vim.g.autoformat
    local buffer_autoformat = vim.b[buffer].autoformat

    -- If the buffer has a local value, use that
    if buffer_autoformat ~= nil then
        return buffer_autoformat
    end

    -- Otherwise use the global value if set, or true by default
    return global_autoformat == nil or global_autoformat
end

---@param buffer? boolean
function M.toggle(buffer)
    if buffer then
        vim.b.autoformat = not M.enabled()
    else
        vim.g.autoformat = not M.enabled()
        vim.b.autoformat = nil
    end

    M.info()
end

---@param opts? {force?: boolean, buffer?: number}
function M.format(opts)
    opts = opts or {}

    local buffer = opts.buffer or vim.api.nvim_get_current_buf()
    if not ((opts and opts.force) or M.enabled(buffer)) then
        return
    end

    local done = false
    for _, formatter in ipairs(M.resolve(buffer)) do
        if formatter.active then
            done = true

            Util.lazy.try(function()
                return formatter.format(buffer)
            end, {
                msg = "Formatter `" .. formatter.name .. "` failed",
            })
        end
    end

    if not done and opts and opts.force then
        Util.lazy.warn("No formatter available", { title = "PickleFormat" })
    end
end

function M.setup()
    -- Autoformat autocmd
    Util.autocmd({
        group = "Format",
        clear = false,
        event = "BufWritePre",
        opts = {
            callback = function(event)
                M.format({ buffer = event.buf })
            end,
        },
    })

    -- Manual format
    Util.usercmd("Format", function()
        M.format({ force = true })
    end, "Format selection or buffer")

    -- Format info
    Util.usercmd("FormatInfo", function()
        M.info()
    end, "Show info about the formatters for the current buffer")
end

return M
