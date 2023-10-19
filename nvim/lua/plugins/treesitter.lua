return {

    {
        "nvim-treesitter/nvim-treesitter",
        event = { "LazyFile" },
        keys = {
            {
                "<leader>Th",
                "<CMD> TSToggle highlight <CR>",
                desc = "Toggle highlighting (Treesitter)",
            },
        },
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/nvim-treesitter-refactor",

            "windwp/nvim-ts-autotag",
        },
        opts = {
            ensure_installed = {
                -- Vim
                "vim",
                "vimdoc",

                -- Lua
                "lua",
                "luadoc",
                "luap",
                "luau",

                -- Markdown
                "markdown",
                "markdown_inline",

                -- Git
                "git_config",
                "git_rebase",
                "gitattributes",
                "gitcommit",
                "gitignore",
                "diff",

                -- Shell
                "bash",

                -- Typescript/Javascript
                "javascript",
                "typescript",
                "tsx",
                "jsdoc",

                -- Json
                "json",
                "json5",
                "jsonc",
                "jsonnet",
                "jq",

                -- Html
                "html",

                -- Css
                "css",

                -- Web
                "http",
                "sql",
                "svelte",
                "vue",
                "prisma",

                -- Rust
                "rust",
                "toml",
                "ron",

                -- Go
                "go",
                "gomod",
                "gowork",
                "gosum",

                -- C
                "c",
                "cpp",

                -- C-Sharp
                "c_sharp",

                -- Python
                "python",
                "ninja",
                "rst",

                -- Yaml
                "yaml",

                -- Terraform
                "terraform",
                "hcl",

                -- Docker
                "dockerfile",

                -- Make
                "make",
                "cmake",

                -- Other
                "regex",
                "todotxt",
                "query",
            },

            sync_install = false,
            auto_install = true,

            modules = {},

            highlight = {
                enable = true,
            },

            incremental_selection = {
                enable = true,
            },

            indent = {
                enable = true,
            },

            textobjects = {
                select = {
                    enable = true,

                    lookahead = true,
                    include_surrounding_whitespace = false,
                },

                swap = {
                    enable = true,
                },

                move = {
                    enable = true,
                },

                lsp_interop = {
                    enable = true,
                },
            },

            refactor = {
                highlight_definitions = {
                    enable = true,

                    clear_on_cursor_move = true,
                },

                highlight_current_scope = {
                    enable = false,
                },

                smart_rename = {
                    enable = false,

                    keymaps = {
                        smart_rename = "grr",
                    },
                },

                navigation = {
                    enable = true,

                    keymaps = {
                        goto_definition = "gnd",
                        list_definitions = "gnD",
                        list_definitions_toc = "gO",
                        goto_next_usage = "<a-*>",
                        goto_previous_usage = "<a-#>",
                    },
                },
            },

            autotag = {
                enable = true,
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
}
