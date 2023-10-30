local Util = require("picklevim.util")

---@class picklevim.config: picklevim.config.opts
local M = {}

---@class picklevim.config.opts
local defaults = {
    colorscheme = "catppuccin",

    ---@class picklevim.config.opts.defaults
    defaults = {
        keymaps = true,
        autocmds = true,
    },

    ---@class picklevim.config.opts.icons
    icons = {
        ---@class picklevim.config.opts.icons.diagnostics
        ---@type table<string, string>
        diagnostics = {
            Error = " ",
            Warn = " ",
            Info = " ",
            Hint = " ",
        },

        ---@class picklevim.config.opts.icons.git
        git = {
            branch = "",
            added = "",
            removed = "",
            modified = "",
        },

        ---@class picklevim.config.opts.icons.telescope
        telescope = {
            prompt = " ",
            caret = " ",
        },

        ---@class picklevim.config.opts.icons.alpha
        alpha = {
            seperator = "",
        },

        ---@class picklevim.config.opts.icons.lsp
        lsp = {
            loaded = "",
        },

        ---@class picklevim.config.opts.icons.noice
        noice = {
            cmdline = " ",
            search_up = " ",
            search_down = " ",
            filter = " ",
            lua = " ",
            help = " ",
        },

        ---@class picklevim.config.opts.icons.kinds
        kinds = {
            Array = " ",
            Boolean = " ",
            Class = "󰠱 ",
            Codeium = "󰘦 ",
            Color = " ",
            Control = " ",
            Collapsed = "󱞩 ",
            Constant = "󰏿 ",
            Constructor = " ",
            Copilot = " ",
            Enum = "󰖽 ",
            EnumMember = "󰖽 ",
            Event = " ",
            Field = " ",
            File = " ",
            Folder = "󰉋 ",
            Function = "󰊕 ",
            Interface = " ",
            Key = " ",
            Keyword = "󰌆 ",
            Method = "󰊕 ",
            Misc = " ",
            Module = " ",
            Namespace = "󰦮 ",
            Null = "󰟢 ",
            Number = "󰎠 ",
            Object = " ",
            Operator = " ",
            Package = " ",
            Property = " ",
            Reference = "󰋺 ",
            Snippet = " ",
            String = " ",
            Struct = "󰙅 ",
            TabNine = "󰏚 ",
            Text = " ",
            TypeParameter = " ",
            Unit = " ",
            Value = " ",
            Variable = "󰀫 ",
        },
    },

    ---@class picklevim.config.opts.kind_filter
    kind_filter = {
        default = {
            "Class",
            "Constructor",
            "Enum",
            "Field",
            "Function",
            "Interface",
            "Method",
            "Module",
            "Namespace",
            "Package",
            "Property",
            "Struct",
            "Trait",
        },

        markdown = false,
        help = false,
        lua = {
            "Class",
            "Constructor",
            "Enum",
            "Field",
            "Function",
            "Interface",
            "Method",
            "Module",
            "Namespace",
            -- "Package",
            "Property",
            "Struct",
            "Trait",
        },
    },
}

---@param buffer? number
---@return string[] | nil
M.get_kind_filter = function(buffer)
    buffer = (buffer == nil or buffer == 0) and vim.api.nvim_get_current_buf()
        or buffer

    local ft = vim.bo[buffer].filetype

    if M.kind_filter and type(M.kind_filter) == "table" then
        if type(M.kind_filter[ft]) == "table" then
            return M.kind_filter[ft] --[[ @as string[] ]]
        end

        if type(M.kind_filter.default) == "table" then
            return M.kind_filter.default --[[ @as string[] ]]
        end
    end

    return nil
end

---@param module "autocmds" | "options" | "keymaps"
M.cache_load = function(module)
    if require("lazy.core.cache").find(module)[1] then
        Util.lazy.try(function()
            require(module)
        end, { msg = "Failed loading " .. module })
    end
end

---@param config "autocmds" | "options" | "keymaps"
M.load_config = function(config)
    -- Load picklevim config files
    if M.defaults[config] or config == "options" then
        M.cache_load("picklevim.config." .. config)
    end

    -- Load user configs
    M.cache_load("config." .. config)

    if vim.bo.filetype == "lazy" then
        vim.cmd([[do VimResized]])
    end

    local pattern = "picklevim_" .. config:sub(1, 1):upper() .. config:sub(2)
    vim.api.nvim_exec_autocmds("User", { pattern = pattern, modeline = false })
end

M.did_init = false
M.init = function()
    if M.did_init then
        return
    end

    M.did_init = true

    Util.delay_notify()

    M.load_config("options")

    Util.plugin.setup()
end

---@class picklevim.config.opts
local options

---@param opts picklevim.config.opts?
M.setup = function(opts)
    options = vim.tbl_deep_extend("force", defaults, opts or {}) or defaults

    local lazy_load_autocmds = vim.fn.argc(-1) == 0
    if not lazy_load_autocmds then
        M.load_config("autocmds")
    end

    Util.autocmd({
        group = "Setup",
        event = "User",
        opts = {
            pattern = "VeryLazy",
            callback = function()
                if lazy_load_autocmds then
                    M.load_config("autocmds")
                end

                M.load_config("keymaps")

                Util.format.setup()
                Util.root.setup()
            end,
        },
    })

    Util.lazy.track("colorscheme")
    Util.lazy.try(function()
        vim.cmd.colorscheme(M.colorscheme)
    end, {
        msg = "Could not load colorsceme",
        on_error = function(msg)
            Util.lazy.error(msg)
        end,
    })
    Util.lazy.track()
end

setmetatable(M, {
    __index = function(_, key)
        if options == nil then
            return vim.deepcopy(defaults)[key]
        end

        return options[key]
    end,
})

return M
