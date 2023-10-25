return {
    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
        opts = {},
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

            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
}
