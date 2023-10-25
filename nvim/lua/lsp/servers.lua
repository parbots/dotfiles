---@class lsp.servers
---@alias server_config {opts?: table, mason?: boolean, keymaps?: picklevim.lsp.keymaps, setup?: fun(_: string, opts: table): boolean}
---@type table<string, server_config>
local M = {
    bashls = {
        opts = {
            filetypes = { "zsh", "bash", "sh" },
        },
    },

    lua_ls = {
        opts = {
            settings = {
                Lua = {
                    completion = {
                        enable = true,

                        callSnippet = "Both",
                        keywordSnippet = "Both",
                    },

                    diagnostic = {
                        enable = true,

                        workspaceDelay = 3000,
                        workspaceEvent = "OnSave",
                    },

                    hint = {
                        enable = true,

                        setType = true,
                    },

                    hover = {
                        enable = true,
                    },

                    signatureHelp = {
                        enable = true,
                    },

                    telemetry = {
                        enable = false,
                    },

                    window = {
                        progressBar = true,
                        statusBar = true,
                    },
                },
            },
        },
    },

    rust_analyzer = {
        opts = {
            server = {
                standalone = false,

                settings = {
                    ["rust_analyzer"] = {
                        cargo = {
                            allFeatures = true,
                            loadOutDirsFromCheck = true,
                            runBuildScripts = true,
                        },

                        checkOnSave = {
                            allFeatures = true,
                            command = "clippy",
                            extraArgs = { "--no-deps" },
                        },

                        procMacro = {
                            enable = true,

                            ignored = {
                                ["async-trait"] = { "async_trait" },
                                ["napi-derive"] = { "napi" },
                                ["async-recursion"] = {
                                    "async_recursion",
                                },
                            },
                        },
                    },
                },
            },
        },

        keymaps = {
            {
                { "n" },
                "<leader>rh",
                "<cmd> RustHoverActions <cr>",
                "Hover Actions (Rust)",
            },
            {
                { "n" },
                "<leader>ra",
                "<cmd> RustCodeAction <cr>",
                "Code Actions (Rust)",
            },
        },

        setup = function(_, opts)
            require("rust-tools").setup(opts)

            return true
        end,
    },

    taplo = {
        opts = {},
        keymaps = {
            {
                { "n" },
                "K",
                function()
                    local crates = require("crates")

                    if
                        vim.fn.expand("%:t") == "Cargo.toml"
                        and crates.popup_available()
                    then
                        crates.show_popup()
                    else
                        vim.lsp.buf.hover()
                    end
                end,
                "Hover (Crates)",
            },
        },
    },

    tsserver = {
        opts = {
            settings = {
                expose_as_code_action = "all",

                tsserver_file_preferences = {
                    includeInlayParameterNameHints = "all",
                    includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = true,
                    includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                },

                code_lens = "all",
                disable_member_code_lens = true,
            },
        },

        setup = function(_, opts)
            require("typescript-tools").setup(opts)

            return true
        end,
    },
}

return M
