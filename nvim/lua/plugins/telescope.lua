local telescope_util = require("util.telescope")

return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = { "Telescope" },
        keys = {
            -- File Pickers
            {
                "<leader>ff",
                "<cmd> Telescope find_files <cr>",
                desc = "Find Files (Telescope)",
            },
            {
                "<leader>sw",
                "<cmd> Telescope grep_string <cr>",
                desc = "Current Word (Telescope)",
            },
            {
                "<leader>sl",
                "<cmd> Telescope live_grep <cr>",
                desc = "Live Grep (Telescope)",
            },
            {
                "<leader>fr",
                "<cmd> Telescope oldfiles <cr>",
                desc = "Find Recent Files (Telescope)",
            },

            -- Vim Pickers
            {
                "<leader>sb",
                "<cmd> Telescope buffers <cr>",
                desc = "Buffers (Telescope)",
            },
            {
                "<leader>sc",
                "<cmd> Telescope commands <cr>",
                desc = "Commands (Telescope)",
            },
            {
                "<leader>sh",
                "<cmd> Telescope help_tags <cr>",
                desc = "Help Tags (Telescope)",
            },
            {
                "<leader>sq",
                "<cmd> Telescope quickfix <cr>",
                desc = "Quickfix (Telescope)",
            },
            {
                "<leader>sL",
                "<cmd> Telescope loclist <cr>",
                desc = "Location List (Telescope)",
            },
            {
                "<leader>sj",
                "<cmd> Telescope jumplist <cr>",
                desc = "Jumplist (Telescope)",
            },
            {
                "<leader>sv",
                "<cmd> Telescope vim_options <cr>",
                desc = "Vim Options (Telescope)",
            },
            {
                "<leader>sk",
                "<cmd> Telescope keymaps <cr>",
                desc = "Keymaps (Telescope)",
            },
            {
                "<leader>si",
                "<cmd> Telescope current_buffer_fuzzy_find <cr>",
                desc = "Current Buffer (Telescope)",
            },

            -- Lsp Pickers
            {
                "<leader>flr",
                "<cmd> Telescope lsp_references <cr>",
                desc = "References (Telescope)",
            },
            {
                "<leader>fls",
                "<cmd> Telescope lsp_document_symbols <cr>",
                desc = "Document Symbols (Telescope)",
            },
            {
                "<leader>flw",
                "<cmd> Telescope lsp_workspace_symbols <cr>",
                desc = "Workspace Symbols (Telescope)",
            },
            {
                "<leader>flW",
                "<cmd> Telescope lsp_dynamic_workspace_symbols <cr>",
                desc = "Dynamic Workspace Symbols (Telescope)",
            },
            {
                "<leader>sd",
                "<cmd> Telescope diagnostics <cr>",
                desc = "Diagnostics (Telescope)",
            },
            {
                "<leader>fli",
                "<cmd> Telescope lsp_implementations <cr>",
                desc = "Implementations (Telescope)",
            },
            {
                "<leader>fld",
                "<cmd> Telescope lsp_definitions <cr>",
                desc = "Definitions (Telescope)",
            },
            {
                "<leader>flt",
                "<cmd> Telescope lsp_type_definitions <cr>",
                desc = "Type Definitions (Telescope)",
            },

            -- Git Pickers
            {
                "<leader>gc",
                "<cmd> Telescope git_commits <cr>",
                desc = "Commits (Telescope)",
            },
            {
                "<leader>gb",
                "<cmd> Telescope git_bcommits <cr>",
                desc = "Branch Commits (Telescope)",
            },
            {
                "<leader>gB",
                "<cmd> Telescope git_branches <cr>",
                desc = "Branches (Telescope)",
            },
            {
                "<leader>gs",
                "<cmd> Telescope git_status <cr>",
                desc = "Status (Telescope)",
            },

            -- Treesitter Pickers
            {
                "<leader>st",
                "<cmd> Telescope treesitter <cr>",
                desc = "Treesitter Nodes (Telescope)",
            },

            -- List Pickers
            {
                "<leader>sp",
                "<cmd> Telescope builtin <cr>",
                desc = "Pickers (Telescope)",
            },

            -- Plugin Pickers
            {
                "<leader>snn",
                "<cmd> Telescope noice <cr>",
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
                    n = telescope_util.n_mappings,
                    i = telescope_util.i_mappings,
                },
            },

            pickers = telescope_util.picker_opts,

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
                telescope_util.custom_flex

            require("telescope").setup(opts)

            telescope_util.set_colors()

            require("telescope").load_extension("fzf")
            require("telescope").load_extension("noice")
        end,
    },
}
