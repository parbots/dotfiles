---@class util.dashboard
local M = {}

M.setup = function(dashboard)
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

        dashboard.button(
            "e",
            "󰝒  >  New File",
            "<cmd> ene <BAR> startinsert <cr>"
        ),
        dashboard.button(
            "r",
            "󰱼  >  Find Recent",
            "<cmd> Telescope oldfiles <cr>"
        ),
        dashboard.button(
            "f",
            "󰱼  >  Find File",
            "<cmd> Telescope find_files <cr>"
        ),
        dashboard.button(
            "w",
            "  >  Find word",
            "<cmd> Telescope live_grep <cr>"
        ),
        dashboard.button("l", "󰏗  >  Lazy", "<cmd> Lazy <cr>"),
        dashboard.button("m", "󰏗  >  Mason", "<cmd> Mason <cr>"),
        dashboard.button("q", "  >  Quit", "<cmd> qa <cr>"),
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

    -- Other Config
    dashboard.config.opts.noautocmd = true

    return dashboard
end

return M
