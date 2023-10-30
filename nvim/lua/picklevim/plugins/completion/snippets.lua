return {
    {
        "L3MON4D3/LuaSnip",
        build = (not jit.os:find("Windows") and "make install_jsregexp") or nil,
        dependencies = {
            {
                "rafamadriz/friendly-snippets",
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                end,
            },
        },
        opts = {
            keep_roots = true,
            link_roots = true,
            link_children = true,

            delete_check_events = "TextChanged",
        },
        config = function(_, opts)
            local luasnip = require("luasnip")

            luasnip.setup(opts)

            -- Web Filetypes
            luasnip.filetype_extend("html", { "javascript" })
            luasnip.filetype_extend("typescript", { "javascript" })
            luasnip.filetype_extend("javascriptreact", { "html", "css" })
            luasnip.filetype_extend("typescriptreact", { "html", "css" })

            -- Shell Filetypes
            luasnip.filetype_extend("zsh", { "bash", "sh" })
            luasnip.filetype_extend("bash", { "zsh", "sh" })
            luasnip.filetype_extend("sh", { "zsh", "bash" })
        end,
    },
}
