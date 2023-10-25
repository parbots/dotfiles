---@class lsp.mason
local M = {}

---@type string[]
M.ensure_installed = {
    -- Shell
    "bash-language-server",
    "shellcheck",
    "shfmt",

    -- Python
    "python-lsp-server",
    "black",
    "isort",

    -- Lua
    "lua-language-server",
    "stylua",

    -- Rust
    "rust-analyzer",
    "taplo",

    -- Javascript/Typescript
    "typescript-language-server",

    -- Json
    "json-lsp",

    -- Web
    "tailwindcss-language-server",
    "prettier",
}

return M
