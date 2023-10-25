return {
    {
        "akinsho/toggleterm.nvim",
        cmd = { "ToggleTerm" },
        keys = {
            { "<C-\\>", desc = "Open (Terminal)" },
        },
        opts = {
            open_mapping = [[<C-\>]],
            insert_mappings = true,
            terminal_mappings = true,

            hide_numbers = true,

            autochdir = true,

            direction = "horizontal",

            float_opts = {
                border = "solid",

                width = math.floor(vim.o.columns * 0.8),
                height = math.floor(vim.o.lines * 0.8),

                winblend = 10,
                zindex = 1000,
            },
        },
    },
}
