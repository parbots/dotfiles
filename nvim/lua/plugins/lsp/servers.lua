local M = {}

M.lua_ls = {
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
}

M.rust_analyzer = {
    opts = {
        keys = {
            {
                { "n", "i" },
                "<c-k>",
                "<CMD> RustHoverActions <CR>",
                "Hover Actions (Rust)",
            },
            {
                { "n" },
                "cR",
                "<CMD> RustCodeAction <CR>",
                "Code Actions (Rust)",
            },
        },

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

    setup = function(_, opts)
        require("rust-tools").setup(vim.tbl_deep_extend("force", {
            server = {
                standalone = false,
            },
        }, { server = opts }))

        return true
    end,
}

M.taplo = {
    opts = {
        keys = {
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
}

M.tsserver = {
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
}

return M
