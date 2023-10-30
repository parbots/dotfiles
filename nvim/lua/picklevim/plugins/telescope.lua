local Util = require("picklevim.util")

return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        keys = {
            -- File Pickers
            {
                "<leader>ff",
                Util.telescope.open("files"),
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
                Util.telescope.open("oldfiles", { cwd = vim.loop.cwd() }),
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
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",

            {
                "nvim-telescope/telescope-fzf-native.nvim",
                enabled = vim.fn.executable("make") == 1,
                build = "make",
                opts = {},
                config = function()
                    Util.plugin.on_load("telescope.nvim", function()
                        require("telescope").load_extension("fzf")
                    end)
                end,
            },

            "folke/noice.nvim",
        },
        opts = function()
            local open_with_trouble = function(...)
                return require("trouble.providers.telescope").open_with_trouble(
                    ...
                )
            end
            local open_selected_with_trouble = function(...)
                return require("trouble.providers.telescope").open_selected_with_trouble(
                    ...
                )
            end

            local find_files_no_ignore = function()
                local action_state = require("telescope.actions.state")
                local line = action_state.get_current_line()

                Util.telescope.open("find_files", {
                    no_ignore = true,
                    no_ignore_parent = true,
                    default_text = line,
                })()
            end

            local find_files_with_hidden = function()
                local action_state = require("telescope.actions.state")
                local line = action_state.get_current_line()

                Util.telescope.open(
                    "find_files",
                    { hidden = true, default_text = line }
                )()
            end

            local general_mappings = {
                ["qq"] = "close",
                ["<C-c>"] = "close",

                ["<Tab>"] = "move_selection_next",
                ["<S-Tab>"] = "move_selection_previous",

                ["<C-s>"] = "select_vertical",
                ["<C-h>"] = "which_key",

                ["<M-i>"] = find_files_no_ignore,
                ["<M-h>"] = find_files_with_hidden,
                ["<M-t>"] = open_with_trouble,
                ["<M-a>"] = open_selected_with_trouble,
            }

            local Config = require("picklevim.config")
            return {
                defaults = {
                    get_selection_window = function()
                        local windows = vim.api.nvim_list_wins()
                        table.insert(windows, 1, vim.api.nvim_get_current_win())
                        for _, window in ipairs(windows) do
                            local buffer = vim.api.nvim_win_get_buf(window)
                            if vim.bo[buffer].buftype == "" then
                                return window
                            end
                        end

                        return 0
                    end,

                    selection_strategy = "reset",
                    scroll_strategy = "cycle",
                    sorting_strategy = "ascending",

                    layout_strategy = "custom_flex",
                    layout_config = {
                        width = 0.8,
                        height = 0.8,
                        prompt_position = "top",
                    },

                    path_display = { "truncate = 3" },

                    border = true,
                    borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },

                    prompt_title = false,
                    prompt_prefix = Config.icons.telescope.prompt,
                    results_title = false,
                    selection_caret = Config.icons.telescope.caret,
                    preview_title = false,

                    winblend = 10,

                    mappings = {
                        n = vim.tbl_deep_extend("error", general_mappings, {
                            ["j"] = "move_selection_next",
                            ["k"] = "move_selection_previous",
                        }),

                        i = vim.tbl_deep_extend("error", general_mappings, {
                            ["jj"] = {
                                "<Esc>",
                                type = "command",
                            },
                            ["jk"] = {
                                "<Esc>",
                                type = "command",
                            },

                            ["<M-j>"] = "move_selection_next",
                            ["<M-k>"] = "move_selection_previous",
                        }),
                    },
                },

                pickers = {
                    live_grep = {
                        max_results = 10000,
                    },

                    find_files = {},

                    treesitter = {
                        show_line = true,
                    },

                    current_buffer_fuzzy_find = {
                        skip_empty_lines = true,
                        results_ts_highlight = true,
                    },

                    git_files = {
                        show_untracked = true,
                    },

                    builtin = {
                        include_extensions = true,
                    },

                    commands = {
                        show_buf_command = true,
                    },

                    quickfix = {
                        trim_text = true,
                    },

                    loclist = {
                        trim_text = true,
                    },

                    oldfiles = {},

                    help_tags = {
                        mappings = {
                            n = {
                                ["<cr>"] = "select_vertical",
                            },

                            i = {
                                ["<cr>"] = "select_vertical",
                            },
                        },
                    },

                    buffers = {
                        ignore_current_buffer = true,
                        sort_mru = true,

                        mappings = {
                            n = {
                                ["<C-x>"] = "delete_buffer",
                            },

                            i = {
                                ["<C-x>"] = "delete_buffer",
                            },
                        },
                    },

                    colorscheme = {
                        enable_preview = true,
                    },

                    keymaps = {
                        modes = { "n", "i", "v" },
                        show_plug = false,
                    },

                    jumplist = {
                        trim_text = true,
                    },

                    lsp_references = {
                        include_current_line = false,

                        trim_text = true,
                    },

                    lsp_definitions = {
                        jump_type = "vsplit",

                        trim_text = true,
                    },

                    lsp_type_definitions = {
                        jump_type = "vsplit",

                        trim_text = true,
                    },

                    lsp_implementations = {
                        jump_type = "vsplit",

                        trim_text = true,
                    },

                    lsp_document_symbols = {
                        symbols = Config.get_kind_filter(),

                        show_line = true,
                    },

                    lsp_workspace_symbols = {
                        symbols = Config.get_kind_filter(),

                        show_line = true,
                    },

                    lsp_dynamic_workspace_symbols = {
                        symbols = Config.get_kind_filter(),

                        show_line = true,
                    },
                },

                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                },
            }
        end,
        config = function(_, opts)
            Util.telescope.setup_layout_strategies()
            Util.telescope.set_colors()

            local telescope = require("telescope")
            telescope.setup(opts)
            telescope.load_extension("noice")
        end,
    },
}
