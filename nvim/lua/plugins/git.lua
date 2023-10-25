return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "LazyFile" },
        opts = function()
            local gs = require("gitsigns")

            return {
                signs = {
                    add = { text = "│" },
                    change = { text = "│" },

                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },

                    untracked = { text = "┆" },
                },

                signcolumn = true,
                numhl = true,
                linehl = false,
                word_diff = false,

                watch_gitdir = {
                    follow_files = true,
                },

                attach_to_untracked = true,

                current_line_blame = false,
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = "right_align",
                    delay = 1000,
                    ignore_whitespace = false,
                },

                preview_config = {
                    border = "none",
                },

                on_attach = function(buffer)
                    local keymap_util = require("util.keymap")

                    keymap_util.map({
                        { { "n" }, "]h", gs.next_hunk, "Next Hunk (Gitsigns)" },
                        {
                            { "n" },
                            "[h",
                            gs.prev_hunk,
                            "Previous Hunk (Gitsigns)",
                        },

                        {
                            { "n", "v" },
                            "ghs",
                            "<cmd> Gitsigns stage_hunk <cr>",
                            "Stage Hunk (Gitsigns)",
                        },
                        {
                            { "n", "v" },
                            "ghr",
                            "<cmd> Gitsigns reset_hunk <cr>",
                            "Reset Hunk (Gitsigns)",
                        },
                        {
                            { "n" },
                            "ghu",
                            gs.undo_stage_hunk,
                            "Undo Stage Hunk (Gitsigns)",
                        },

                        {
                            { "n" },
                            "ghS",
                            gs.stage_buffer,
                            "Stage Buffer (Gitsigns)",
                        },
                        {
                            { "n" },
                            "ghR",
                            gs.reset_buffer,
                            "Reset Buffer (Gitsigns)",
                        },

                        {
                            { "n" },
                            "ghp",
                            gs.preview_hunk,
                            "Preview Hunk (Gitsigns)",
                        },

                        {
                            { "n" },
                            "ghb",
                            function()
                                gs.blame_line({ full = true })
                            end,
                            "Blame Line (Gitsigns)",
                        },

                        {
                            { "n" },
                            "ghd",
                            gs.diffthis,
                            "Diff This (Gitsigns)",
                        },
                        {
                            { "n" },
                            "ghD",
                            function()
                                gs.diffthis("~")
                            end,
                            "Diff This ~ (Gitsigns)",
                        },

                        {
                            { "o", "x" },
                            "ih",
                            "<C-U> <cmd> Gitsigns select_hunk <cr>",
                            "Select Hunk (Gitsigns)",
                        },
                    }, { buffer = buffer })
                end,
            }
        end,
    },

    {
        "akinsho/git-conflict.nvim",
        event = { "LazyFile" },
        opts = {
            default_mappings = true,
            default_commands = true,
            disable_diagnostics = true,

            list_opener = "copen",

            highlights = {
                incoming = "DiffAdd",
                current = "DiffText",
            },
        },
    },

    {
        "sindrets/diffview.nvim",
        cmd = {
            "DiffviewOpen",
            "DiffviewFileHistory",
        },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            enhanced_diff_hl = true,
        },
    },

    {
        "NeogitOrg/neogit",
        keys = {
            { "<leader>on", "<cmd> Neogit <cr>", desc = "Neogit" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",

            "nvim-telescope/telescope.nvim",
        },
        opts = {
            disable_insert_on_commit = "auto",

            telescope_sorter = function()
                return require("telescope").extensions.fzf.native_fzf_sorter()
            end,
        },
    },

    {
        "pwntester/octo.nvim",
        cmd = "Octo",
        keys = {
            { "<leader>oo", "<cmd> Octo <cr>", desc = "Octo" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",

            "nvim-telescope/telescope.nvim",
        },
        opts = {
            enable_builtin = true,
        },
    },
}
