return {

    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
        opts = {},
        config = function(_, opts)
            local luasnip = require("luasnip")

            luasnip.setup(opts)

            luasnip.filetype_extend("html", { "javascript" })
            luasnip.filetype_extend("typescript", { "javascript" })
            luasnip.filetype_extend("javascriptreact", { "html", "css" })
            luasnip.filetype_extend("typescriptreact", { "html", "css" })

            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },

    {
        "hrsh7th/nvim-cmp",
        event = { "LazyFile" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-cmdline",
            "FelipeLema/cmp-async-path",
            "hrsh7th/cmp-buffer",

            "L3MON4D3/LuaSnip",

            "onsails/lspkind.nvim",
        },
        opts = {
            window = {
                completion = {
                    border = "none",
                },

                documentation = {
                    border = "none",
                },
            },

            view = {
                entries = {
                    name = "custom",
                    selection_order = "near_cursor",
                },
            },

            completion = {
                completeopt = "menuone,noinsert,noselect",
            },

            experimental = {
                ghost_text = {
                    hl_group = "CmpGhostText",
                },
            },
        },
        config = function(_, opts)
            local cmp = require("cmp")
            local lspkind = require("lspkind")
            local luasnip = require("luasnip")

            vim.api.nvim_set_hl(
                0,
                "CmpGhostText",
                { link = "Comment", default = true }
            )

            cmp.setup(vim.tbl_deep_extend("error", opts, {
                formatting = {
                    format = function(entry, vim_item)
                        local kind = lspkind.cmp_format({
                            mode = "symbol_text",
                            maxwidth = 80,
                            ellipsis_char = "...",
                            menu = {
                                nvim_lsp = "[lsp]",
                                luasnip = "[luasnip]",
                                nvim_lua = "[lua]",
                                crates = "[crate]",
                                async_path = "[path]",
                                buffer = "[buffer]",
                                cmdline = "[cmd]",
                            },
                        })(entry, vim_item)

                        kind.kind = " " .. kind.kind .. " "

                        return kind
                    end,
                },

                preselect = cmp.PreselectMode.None,

                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },

                mapping = {
                    ["<C-Space>"] = cmp.mapping.complete(),

                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),

                    ["<C-e>"] = cmp.mapping.abort(),

                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                },

                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "async_path" },
                }, {
                    {
                        name = "buffer",
                        option = {
                            keyword_length = 1,
                            get_bufnrs = function()
                                return vim.api.nvim_list_bufs()
                            end,
                        },
                    },
                    { name = "nvim_lua" },
                    { name = "crates" },
                }),
            }))

            ---@diagnostic disable-next-line: missing-fields
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = {
                    ["<Tab>"] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.select_next_item()
                        end
                    end, { "s", "c" }),
                    ["<S-Tab>"] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.select_prev_item()
                        end
                    end, { "s", "c" }),
                    ["<CR>"] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.confirm({ select = false })
                        end
                    end),
                },
                sources = {
                    {
                        name = "buffer",
                        option = {
                            keyword_length = 1,
                        },
                    },
                },
            })

            ---@diagnostic disable-next-line: missing-fields
            cmp.setup.cmdline({ ":" }, {
                mapping = {
                    ["<Tab>"] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.select_next_item()
                        end
                    end, { "i", "s", "c" }),
                    ["<S-Tab>"] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.select_prev_item()
                        end
                    end, { "i", "s", "c" }),
                    ["<CR>"] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.confirm({ select = false })
                        end
                    end),
                },
                sources = {
                    { name = "cmdline" },
                    { name = "async_path" },
                },
            })

            -- Automatically place pairs on snippet completions
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },
}
