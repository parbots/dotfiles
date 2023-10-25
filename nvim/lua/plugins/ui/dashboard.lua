return {
    {
        "goolord/alpha-nvim",
        event = { "VimEnter" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
        config = function()
            local Util = require("util")

            local alpha = require("alpha")
            local alpha_dashboard_theme = require("alpha.themes.dashboard")

            local dashboard = Util.dashboard.setup(alpha_dashboard_theme)

            alpha.setup(dashboard.config)

            vim.api.nvim_create_autocmd("User", {
                pattern = { "VeryLazy", "VimEnter", "UIEnter" },
                group = Util.augroup("dashboard_stats"),
                callback = function()
                    local stats = require("lazy.stats").stats()

                    dashboard.section.buttons.val[1].val = "󱐋 Lazy loaded "
                        .. stats.loaded
                        .. " / "
                        .. stats.count
                        .. " plugins in "
                        .. stats.startuptime
                        .. "ms 󱐋"

                    pcall(vim.cmd.AlphaRedraw)
                end,
            })
        end,
    },
}
