return {
    {
        "williamboman/mason.nvim",
        cmd = { "Mason" },
        keys = {
            { "<leader>om", "<cmd> Mason <cr>", desc = "Mason" },
        },
        build = ":MasonUpdate",
        opts = {
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

            local mason_utils = require("picklevim.util.mason")
            mason_utils.refresh_on_success()
            mason_utils.ensure_installed()
        end,
    },
}
