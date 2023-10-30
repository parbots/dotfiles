return {
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter" },
        cmd = { "CmpStatus" },
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
        opts = function()
            vim.api.nvim_set_hl(
                0,
                "CmpGhostText",
                { link = "Comment", default = true }
            )

            local cmp = require("cmp")
            local defaults = require("cmp.config.default")()
            local lspkind = require("lspkind")
            local luasnip = require("luasnip")
            return {
                experimental = {
                    ghost_text = {
                        hl_group = "CmpGhostText",
                    },
                },

                completion = {
                    completeopt = "menuone,noinsert,noselect",

                    keyword_length = 1,
                },

                window = {
                    max_width = math.floor(vim.o.columns * 0.8),
                    max_height = math.floor(vim.o.lines * 0.8),

                    border = "none",

                    scrollbar = true,

                    scrolloff = 8,

                    completion = {
                        max_width = math.floor(vim.o.columns * 0.4),
                        max_height = math.floor(vim.o.lines * 0.4),

                        border = "none",

                        scrollbar = true,

                        scrolloff = 8,
                    },

                    documentation = {
                        max_width = math.floor(vim.o.columns * 0.4),
                        max_height = math.floor(vim.o.lines * 0.4),

                        border = "solid",

                        scrollbar = true,

                        scrolloff = 8,
                    },
                },

                view = {
                    entries = {
                        name = "custom",
                        selection_order = "near_cursor",
                    },

                    docs = {
                        auto_open = true,
                    },
                },

                formatting = {
                    expandable_indicator = true,

                    fields = { "abbr", "kind", "menu" },

                    format = function(entry, vim_item)
                        local kind = lspkind.cmp_format({
                            mode = "symbol_text",
                            maxwidth = math.floor(vim.o.columns * 0.4),
                            ellipsis_char = "…",
                            symbol_map = require("picklevim.config").icons.kinds,
                            menu = {
                                async_path = "[pth]",
                                buffer = "[buf]",

                                nvim_lsp = "[lsp]",
                                luasnip = "[snp]",

                                cmdline = "[cmd]",

                                nvim_lua = "[lua]",
                                crates = "[crt]",
                            },
                        })(entry, vim_item)

                        kind.kind = " " .. kind.kind .. " "

                        return kind
                    end,
                },

                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },

                preselect = cmp.PreselectMode.None,

                mapping = {
                    ["<C-Space>"] = cmp.mapping.complete(),

                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),

                    ["<C-e>"] = cmp.mapping.abort(),

                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                    ["<cr>"] = cmp.mapping.confirm({ select = false }),
                },

                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "async_path" },
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

                sorting = defaults.sorting,
                matching = defaults.matching,
                confirmation = defaults.confirmation,
                performance = defaults.performance,
            }
        end,
        config = function(_, opts)
            for _, source in ipairs(opts.sources) do
                source.group_index = source.group_index or 1
            end

            local cmp = require("cmp")

            cmp.setup(opts)

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
                    ["<cr>"] = cmp.mapping(function()
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
                    ["<cr>"] = cmp.mapping(function()
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
