-- Enable the neovim loader
if vim.loader then
    vim.loader.enable()
end

-- Load Lazy.nvim and plugins
require("config.lazy").setup({
    profiling = {
        loader = true,
        require = true,
    },
})

-- Load PickleVim
require("picklevim").setup()
