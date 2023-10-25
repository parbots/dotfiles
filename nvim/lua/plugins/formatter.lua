return {
    {
        "stevearc/conform.nvim",
        event = { "LazyFile" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<C-f>",
                function()
                    require("conform").format({
                        async = false,
                        timeout_ms = 1000,
                        lsp_fallback = true,
                    })
                end,
                mode = { "n", "v", "i" },
                desc = "Format File (Conform)",
            },
            {
                "<leader>ci",
                "<cmd> ConformInfo <cr>",
                desc = "Info (Conform)",
            },
        },
        init = function()
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
        opts = {
            format_on_save = {
                async = false,
                timeout_ms = 1000,
                lsp_fallback = true,
            },

            formatters_by_ft = {
                -- Lua
                lua = { "stylua" },

                -- Rust
                toml = { "taplo" },
                rust = { "rustfmt" },

                -- Javascript/Typescript
                javascript = { "prettier" },
                javascriptreact = { "prettier" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },

                -- Html and CSS
                html = { "prettier" },
                css = { "prettier" },

                -- Json
                json = { "prettier" },
                jsonc = { "prettier" },

                -- Markdown
                markdown = { "prettier" },

                -- Python
                python = { "isort", "black" },

                -- Shell
                zsh = { "shfmt" },
                bash = { "shfmt" },
                shell = { "shfmt" },

                -- Any
                ["*"] = {
                    "trim_newlines",
                    "squeeze_blanks",
                    "trim_whitespace",
                },
            },

            formatters = {
                stylua = {
                    args = {
                        "--column-width",
                        "80",
                        "--indent-type",
                        "spaces",
                        "--indent-width",
                        "4",
                        "--search-parent-directories",
                        "--stdin-filepath",
                        "$FILENAME",
                        "-",
                    },
                },

                prettier = {
                    args = {
                        "--tab-width",
                        "4",
                        "--stdin-filepath",
                        "$FILENAME",
                    },
                },
            },
        },
    },
}
