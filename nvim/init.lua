-- Enable the neovim loader
if vim.loader then
    vim.loader.enable()
end

-- Load vim configuration options
require("config.options")

-- Load vim configuration options
require("config.autocmds")

-- Load keymaps
require("config.keymaps")

-- Load Lazy.nvim and plugins
require("config.lazy")({
    profiling = {
        loader = false,
        require = false,
    },
})
