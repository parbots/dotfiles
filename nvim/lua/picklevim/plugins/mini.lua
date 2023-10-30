return {

    {
        "echasnovski/mini.ai",
        event = { "LazyFile" },
        opts = {
            n_lines = 1000,
        },
    },

    { "echasnovski/mini.align", event = { "LazyFile" }, opts = {} },

    { "echasnovski/mini.bracketed", event = { "LazyFile" }, opts = {} },

    {
        "echasnovski/mini.indentscope",
        event = { "LazyFile" },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup(
                    "picklevim_disable_indentscope",
                    { clear = true }
                ),
                pattern = {
                    "alpha",
                    "help",
                    "lazy",
                    "man",
                    "mason",
                    "notify",
                    "oil",
                    "Trouble",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
        opts = {
            symbol = "│",
            options = {
                border = "both",
                indent_at_cursor = true,
                try_as_border = true,
            },
        },
    },

    { "echasnovski/mini.move", event = { "LazyFile" }, opts = {} },
}
