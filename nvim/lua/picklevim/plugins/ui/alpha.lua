return {
    {
        "goolord/alpha-nvim",
        event = { "VimEnter" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
        config = function()
            local dashboard = require("alpha.themes.dashboard")

            -- Header Section
            dashboard.opts.layout[1].val = 5
            dashboard.section.header.val = {
                [[                               __                ]],
                [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
                [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
                [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
                [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
                [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
            }
            dashboard.opts.layout[3].val = 1

            local icons = require("picklevim.config").icons.alpha

            local button = function(key, command, icon, text)
                text = icon .. "  " .. icons.seperator .. "  " .. text
                return dashboard.button(key, text, command)
            end

            -- Buttons Section
            dashboard.section.buttons.val = {
                {
                    type = "text",
                    val = " ",
                    opts = {
                        position = "center",
                        hl = "AlphaHeaderLabel",
                    },
                },

                {
                    type = "padding",
                    val = 0,
                },

                button(
                    "e",
                    "<cmd> ene <BAR> startinsert <cr>",
                    "󰝒",
                    "New File"
                ),
                button(
                    "r",
                    "<cmd> Telescope oldfiles <cr>",
                    "󰱼",
                    "Find Recent"
                ),
                button(
                    "f",
                    "<cmd> Telescope find_files <cr>",
                    "󰱼",
                    "Find File"
                ),
                button(
                    "w",
                    "<cmd> Telescope live_grep <cr>",
                    "",
                    "Find word"
                ),
                button("l", "<cmd> Lazy <cr>", "󰏗", "Lazy"),
                button("m", "<cmd> Mason <cr>", "󰏗", "Mason"),
                button("q", "<cmd> qa <cr>", "", "Quit"),
            }
            dashboard.section.buttons.opts.spacing = 1

            -- Footer Section
            local fortune = require("alpha.fortune")
            dashboard.section.footer.val = fortune()

            -- Highlights
            dashboard.section.header.opts.hl = "AlphaHeader"
            for _, item in ipairs(dashboard.section.buttons.val) do
                if item.type == "button" then
                    item.opts.hl = "AlphaButtons"
                    item.opts.hl_shortcut = "AlphaShortcut"
                end
            end
            dashboard.section.footer.opts.hl = "AlphaFooter"

            require("alpha").setup(dashboard.config)

            local Util = require("picklevim.util")
            Util.autocmd({
                group = "alpha_stats",
                event = "User",
                opts = {
                    pattern = { "VeryLazy", "VimEnter", "UIEnter" },
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
                },
            })

            if vim.o.filetype == "lazy" then
                vim.cmd.close()

                Util.autocmd({
                    group = "alpha_reopen_lazy",
                    event = "User",
                    opts = {
                        pattern = "AlphaReady",
                        callback = function()
                            require("lazy").show()
                        end,
                    },
                })
            end
        end,
    },
}
