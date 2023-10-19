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
                "<CMD> ConformInfo <CR>",
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
                lua = { "stylua" },

                toml = { "taplo" },
                rust = { "rustfmt" },

                javascript = { "prettier" },
                javascriptreact = { "prettier" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },

                html = { "prettier" },
                css = { "prettier" },

                json = { "prettier" },
                jsonc = { "prettier" },

                markdown = { "prettier" },

                python = { "isort", "black" },

                shell = { "beautysh" },
                sh = { "beautysh" },
                zsh = { "beautysh" },
                bash = { "beautysh" },

                ["*"] = {
                    "trim_whitespace",
                    "trim_newlines",
                    "squeeze_blanks",
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
