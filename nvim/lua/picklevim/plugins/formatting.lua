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
        -- dependencies = { { "mason.nvim" } },
        init = function()
            local Util = require("picklevim.util")

            Util.on_verylazy(function()
                local conform = require("conform")

                Util.format.register({
                    name = "conform.nvim",
                    priority = 100,
                    primary = true,
                    format = function(buffer)
                        local opts = Util.plugin.get_opts("conform.nvim")

                        conform.format(
                            Util.lazy.merge(opts.format, { bufnr = buffer })
                        )
                    end,
                    sources = function(buffer)
                        local formatters = conform.list_formatters(buffer)
                        local sources = vim.tbl_map(function(formatter_info)
                            return formatter_info.name
                        end, formatters)

                        return sources
                    end,
                })
            end)
        end,
        opts = {
            format = {
                timeout_ms = 3000,
                async = false,
                quiet = false,
            },

            ---@type table<string, conform.FormatterUnit[]>
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
                injected = { options = { ignore_errors = true } },

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
        config = function(_, opts)
            for _, key in ipairs({ "format_on_save", "format_after_save" }) do
                if opts[key] then
                    opts[key] = nil
                end
            end

            require("conform").setup(opts)
        end,
    },
}
