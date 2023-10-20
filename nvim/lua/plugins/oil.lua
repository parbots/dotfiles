return {
    {
        "stevearc/oil.nvim",
        cmd = { "Oil" },
        keys = {
            { "<leader>fe", "<cmd> Oil <cr>", desc = "File Explorer (Oil)" },
            {
                "<C-e>",
                function()
                    require("oil").toggle_float()
                end,
                desc = "Toggle File Explorer (Oil)",
            },
        },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            default_file_explorer = true,

            columns = {
                "icon",
            },

            buf_options = {
                buflisted = false,
                bufhidden = "hide",
            },

            win_options = {
                wrap = false,
                signcolumn = "no",
                cursorcolumn = false,
                foldcolumn = "0",
                spell = false,
                list = false,
                conceallevel = 3,
                concealcursor = "nvic",
            },

            delete_to_trash = false,
            skip_confirm_for_simple_edits = false,
            prompt_save_on_select_new_entry = true,
            cleanup_delay_ms = 0,

            keymaps = {
                ["<C-h>"] = "actions.show_help",

                ["<cr>"] = "actions.select",
                ["<C-c>"] = "actions.close",
                ["<C-l>"] = "actions.refresh",

                ["<C-s>"] = "actions.select_vsplit",

                ["<C-p>"] = "actions.preview",

                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = "actions.tcd",

                ["gs"] = "actions.change_sort",
                ["g."] = "actions.toggle_hidden",
            },
            use_default_keymaps = true,

            view_options = {
                show_hidden = true,

                is_hidden_file = function(name)
                    return vim.startswith(name, ".")
                end,
            },

            float = {
                max_width = 0,
                max_height = 0,

                padding = 3,
                border = "solid",

                win_options = {
                    winblend = 10,
                },
            },

            preview = {
                min_width = 0.4,
                max_width = 0.8,
                min_height = 0.4,
                max_height = 0.8,

                border = "solid",
            },

            progress = {
                min_width = 0.4,
                min_height = 0.4,

                max_width = 0.8,
                max_height = 0.8,

                border = "solid",
                minimized_border = "none",
            },
        },
    },
}
