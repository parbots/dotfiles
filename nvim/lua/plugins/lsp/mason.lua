return {
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = {
            { "<leader>om", "<cmd> Mason <cr>", desc = "Mason" },
        },
        build = ":MasonUpdate",
        opts = {
            ensure_installed = require("lsp.mason").ensure_installed,

            max_concurrent_installers = 5,

            pip = {
                upgrade_pip = true,
            },

            ui = {
                width = 0.8,
                height = 0.8,
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)

            local mason_util = require("util.mason")
            mason_util.refresh_on_success()
            mason_util.ensure_installed()
        end,
    },
}
