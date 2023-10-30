local Util = require("picklevim.util")

---@class picklevim.util.root
local M = setmetatable({}, {
    __call = function(m)
        return m.get()
    end,
})

---@alias picklevim.root.fn fun(buffer: number): (string | string[])
---@alias picklevim.root.spec string | string[] | picklevim.root.fn

---@class picklevim.root
---@field paths string[]
---@field spec picklevim.root.spec

---@type picklevim.root.spec[]
M.spec = { "lsp", { ".git", "lua" }, "cwd" }

M.detectors = {}

-- Returns the current working directory
---@return table<string, string | nil>
M.detectors.cwd = function()
    return { vim.loop.cwd() }
end

-- Returns the current workspace directories of each lsp client attached to the
-- buffer
---@param buffer number
---@return string[]
M.detectors.lsp = function(buffer)
    local buffer_path = M.bufpath(buffer)
    if not buffer_path then
        return {}
    end

    ---@type string[]
    local roots = {}

    for _, client in pairs(Util.lsp.clients.get_buf(buffer)) do
        local workspace_folders = client.config.workspace_folders
        for _, folder in pairs(workspace_folders or {}) do
            roots[#roots + 1] = vim.uri_to_fname(folder.uri)
        end
    end

    return vim.tbl_filter(function(path)
        path = Util.lazy.norm(path)
        return path and buffer_path:find(path, 1, true) == 1
    end, roots)
end

-- Searches for and returns the first match of `pattern` in current working directory or buffer path
---@param buffer number
---@param patterns string | string[]
---@return table<string, string | nil>
M.detectors.pattern = function(buffer, patterns)
    patterns = type(patterns) == "string" and { patterns } or patterns

    local path = M.bufpath(buffer) or vim.loop.cwd()
    local pattern = vim.fs.find(patterns, {
        path = path,
        upward = true,
    })[1]

    return pattern and { vim.fs.dirname(pattern) } or {}
end

-- Returns the absolute path of `buffer`
---@param buffer number
---@return string | nil
M.bufpath = function(buffer)
    return M.realpath(vim.api.nvim_buf_get_name(assert(buffer)))
end

-- Returns the absolute path of the current working directory
---@return string
M.cwd = function()
    return M.realpath(vim.loop.cwd()) or ""
end

-- Returns the absolute path of a `path`
---@param path string | nil
---@return string | nil
M.realpath = function(path)
    if path == "" or path == nil then
        return nil
    end

    ---@type string
    path = vim.loop.fs_realpath(path) or path

    return Util.lazy.norm(path)
end

-- Returns a root function from a root specification
---@param spec picklevim.root.spec
---@return picklevim.root.fn
M.resolve = function(spec)
    if M.detectors[spec] then
        return M.detectors[spec]
    elseif type(spec) == "function" then
        return spec
    end

    return function(buffer)
        return M.detectors.pattern(buffer, spec)
    end
end

-- Returns all detected roots based on the root specification
---@param opts {buffer?: number, spec?: picklevim.root.spec[], all?: boolean}
M.detect = function(opts)
    -- Set options
    opts = opts or {}
    opts.spec = opts.spec
        or type(vim.g.root_spec) == "table" and vim.g.root_spec
        or M.spec
    opts.buffer = (opts.buffer == nil or opts.buffer == 0)
            and vim.api.nvim_get_current_buf()
        or opts.buffer

    -- Detect roots
    ---@type picklevim.root[]
    local roots = {}
    for _, spec in ipairs(opts.spec) do
        local detect = M.resolve(spec)
        local paths = detect(opts.buffer) or {}

        ---@type string[]
        paths = type(paths) == "table" and paths or { paths }

        ---@type string[]
        local root_paths = {}
        for _, path in ipairs(paths) do
            local realpath = M.realpath(path)
            if realpath and not vim.tbl_contains(roots, realpath) then
                root_paths[#root_paths + 1] = realpath
            end
        end

        table.sort(root_paths, function(a, b)
            return #a > #b
        end)

        if #root_paths > 0 then
            roots[#roots + 1] = {
                spec = spec,
                paths = root_paths,
            }

            if opts.all == false then
                break
            end
        end
    end

    return roots
end

-- Get info about root directories
---@return string | string[] | nil
M.info = function()
    ---@type picklevim.root.spec
    local spec = type(vim.g.root_spec) == "table" and vim.g.root_spec or M.spec

    local roots = M.detect({ all = true })

    ---@type string[]
    local lines = {}
    local first = true
    for _, root in ipairs(roots) do
        for _, path in ipairs(root.paths) do
            lines[#lines + 1] = ("- [%s] `%s` **(%s)**"):format(
                first and "x" or " ",
                path,
                ---@diagnostic disable-next-line: param-type-mismatch
                type(root.spec) == "table" and table.concat(root.spec, ", ")
                    or root.spec
            )
            first = false
        end
    end

    lines[#lines + 1] = "```lua"
    lines[#lines + 1] = "vim.g.root_spec = " .. vim.inspect(spec)
    lines[#lines + 1] = "```"

    Util.lazy.info(lines, { title = "PickleVim Roots" })
    return roots[1] and roots[1].paths[1] or vim.loop.cwd()
end

---@type table<number, string>
M.cache = {}

-- Setup root utility
M.setup = function()
    Util.usercmd("Root", function()
        Util.root.info()
    end, "PickleVim roots for the current buffer")

    Util.autocmd({
        group = "root_cache",
        event = { "LspAttach", "BufWritePost" },
        opts = {
            callback = function(event)
                M.cache[event.buf] = nil
            end,
        },
    })
end

-- Get the root directory
---@param opts? {normalize?: boolean}
---@return string
M.get = function(opts)
    local buffer = vim.api.nvim_get_current_buf()
    local root = M.cache[buffer]

    if not root then
        local roots = M.detect({ all = true })
        root = roots[1] and roots[1].paths[1] or vim.loop.cwd()
        M.cache[buffer] = root
    end

    if opts and opts.normalize then
        return root
    end

    return Util.is_win() and root:gsub("/", "\\") or root
end

return M
