local Util = require("util")

return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = { "Telescope" },
        keys = {
            -- File Pickers
            {
                "<leader>ff",
                "<CMD> Telescope find_files <CR>",
                desc = "Find Files (Telescope)",
            },
            {
                "<leader>sw",
                "<CMD> Telescope grep_string <CR>",
                desc = "Current Word (Telescope)",
            },
            {
                "<leader>sl",
                "<CMD> Telescope live_grep <CR>",
                desc = "Live Grep (Telescope)",
            },
            {
                "<leader>fr",
                "<CMD> Telescope oldfiles <CR>",
                desc = "Find Recent Files (Telescope)",
            },

            -- Vim Pickers
            {
                "<leader>sb",
                "<CMD> Telescope buffers <CR>",
                desc = "Buffers (Telescope)",
            },
            {
                "<leader>sc",
                "<CMD> Telescope commands <CR>",
                desc = "Commands (Telescope)",
            },
            {
                "<leader>sh",
                "<CMD> Telescope help_tags <CR>",
                desc = "Help Tags (Telescope)",
            },
            {
                "<leader>sq",
                "<CMD> Telescope quickfix <CR>",
                desc = "Quickfix (Telescope)",
            },
            {
                "<leader>sL",
                "<CMD> Telescope loclist <CR>",
                desc = "Location List (Telescope)",
            },
            {
                "<leader>sj",
                "<CMD> Telescope jumplist <CR>",
                desc = "Jumplist (Telescope)",
            },
            {
                "<leader>sv",
                "<CMD> Telescope vim_options <CR>",
                desc = "Vim Options (Telescope)",
            },
            {
                "<leader>sk",
                "<CMD> Telescope keymaps <CR>",
                desc = "Keymaps (Telescope)",
            },
            {
                "<leader>si",
                "<CMD> Telescope current_buffer_fuzzy_find <CR>",
                desc = "Current Buffer (Telescope)",
            },

            -- Lsp Pickers
            {
                "<leader>flr",
                "<CMD> Telescope lsp_references <CR>",
                desc = "References (Telescope)",
            },
            {
                "<leader>fls",
                "<CMD> Telescope lsp_document_symbols <CR>",
                desc = "Document Symbols (Telescope)",
            },
            {
                "<leader>flw",
                "<CMD> Telescope lsp_workspace_symbols <CR>",
                desc = "Workspace Symbols (Telescope)",
            },
            {
                "<leader>flW",
                "<CMD> Telescope lsp_dynamic_workspace_symbols <CR>",
                desc = "Dynamic Workspace Symbols (Telescope)",
            },
            {
                "<leader>sd",
                "<CMD> Telescope diagnostics <CR>",
                desc = "Diagnostics (Telescope)",
            },
            {
                "<leader>fli",
                "<CMD> Telescope lsp_implementations <CR>",
                desc = "Implementations (Telescope)",
            },
            {
                "<leader>fld",
                "<CMD> Telescope lsp_definitions <CR>",
                desc = "Definitions (Telescope)",
            },
            {
                "<leader>flt",
                "<CMD> Telescope lsp_type_definitions <CR>",
                desc = "Type Definitions (Telescope)",
            },

            -- Git Pickers
            {
                "<leader>gc",
                "<CMD> Telescope git_commits <CR>",
                desc = "Commits (Telescope)",
            },
            {
                "<leader>gb",
                "<CMD> Telescope git_bcommits <CR>",
                desc = "Branch Commits (Telescope)",
            },
            {
                "<leader>gB",
                "<CMD> Telescope git_branches <CR>",
                desc = "Branches (Telescope)",
            },
            {
                "<leader>gs",
                "<CMD> Telescope git_status <CR>",
                desc = "Status (Telescope)",
            },

            -- Treesitter Pickers
            {
                "<leader>st",
                "<CMD> Telescope treesitter <CR>",
                desc = "Treesitter Nodes (Telescope)",
            },

            -- List Pickers
            {
                "<leader>sp",
                "<CMD> Telescope builtin <CR>",
                desc = "Pickers (Telescope)",
            },

            -- Plugin Pickers
            {
                "<leader>snn",
                "<CMD> Telescope noice <CR>",
                desc = "All (Telescope)",
            },
        },
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",

            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },

            "folke/noice.nvim",
        },
        opts = {
            defaults = {
                vimgrep_arguments = {
                    "rg",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--hidden",
                    "--glob",
                    "!**/.git/*",
                },

                selection_strategy = "reset",
                scroll_strategy = "cycle",
                sorting_strategy = "ascending",

                layout_strategy = "custom_flex",
                layout_config = {
                    width = 0.8,
                    height = 0.8,
                    prompt_position = "top",
                },

                path_display = { "smart" },

                border = true,
                borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },

                prompt_title = false,
                prompt_prefix = "  ",
                results_title = false,
                selection_caret = "  ",
                preview_title = false,

                winblend = 10,

                mappings = {
                    n = Util.telescope.n_mappings,
                    i = Util.telescope.i_mappings,
                },
            },

            pickers = Util.telescope.picker_opts,

            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
        },
        config = function(_, opts)
            require("telescope.pickers.layout_strategies").custom_flex =
                Util.telescope.custom_flex

            require("telescope").setup(opts)

            Util.telescope.set_colors()

            require("telescope").load_extension("fzf")
            require("telescope").load_extension("noice")
        end,
    },
}
