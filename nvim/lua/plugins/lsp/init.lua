local Util = require("util")

return {

    -- #########################################################################
    -- # Servers
    -- #########################################################################

    {
        "saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            src = {
                cmp = {
                    enabled = true,
                },
            },
        },
        config = function(_, opts)
            local crates = require("crates")

            crates.setup(opts)

            Util.map({
                -- Popups
                {
                    { "n" },
                    "<leader>Cv",
                    crates.show_versions_popup,
                    "Show crate versions",
                },
                {
                    "n",
                    "<leader>Cf",
                    crates.show_features_popup,
                    "Show crate features",
                },
                {
                    "n",
                    "<leader>Cd",
                    crates.show_dependencies_popup,
                    "Show crate dependencies",
                },

                -- Update crates
                { "n", "<leader>Cu", crates.update_crate, "Update crate" },
                {
                    "v",
                    "<leader>Cu",
                    crates.update_crates,
                    "Update selected crates",
                },
                {
                    "n",
                    "<leader>Ca",
                    crates.update_all_crates,
                    "Update all crates",
                },

                -- Upgrade Crates
                { "n", "<leader>CU", crates.upgrade_crate, "Upgrade crate" },
                {
                    "v",
                    "<leader>CU",
                    crates.upgrade_crates,
                    "Upgrade selected crates",
                },
                {
                    "n",
                    "<leader>CA",
                    crates.upgrade_all_crates,
                    "Upgrade all crates",
                },
            })
        end,
    },

    -- #########################################################################
    -- # Mason
    -- #########################################################################
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = {
            { "<leader>om", "<cmd> Mason <cr>", desc = "Mason" },
        },
        build = ":MasonUpdate",
        opts = {
            ensure_installed = {
                -- Shell
                "bash-language-server",
                "beautysh",
                "shellcheck",

                -- Python
                "python-lsp-server",
                "black",
                "isort",

                -- Lua
                "lua-language-server",
                "stylua",

                -- Rust
                "rust-analyzer",
                "taplo",

                -- Javascript/Typescript
                "typescript-language-server",

                -- Json
                "json-lsp",

                -- Web
                "tailwindcss-language-server",
                "prettier",
            },

            max_concurrent_installers = 5,

            pip = {
                upgrade_pip = true,
            },

            ui = {
                width = 0.8,
                height = 0.8,
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)

            local mason_registry = require("mason-registry")

            mason_registry:on("package:install:success", function()
                vim.defer_fn(function()
                    require("lazy.core.handler.event").trigger({
                        event = "FileType",
                        buf = vim.api.nvim_get_current_buf(),
                    })
                end, 100)
            end)

            local install_packages = function()
                for _, package_name in ipairs(opts.ensure_installed) do
                    local mason_package =
                        mason_registry.get_package(package_name)

                    if not mason_package:is_installed() then
                        mason_package:install()
                    end
                end
            end

            if mason_registry.refresh then
                mason_registry.refresh(install_packages())
            else
                install_packages()
            end
        end,
    },

    -- #########################################################################
    -- # Lspconfig
    -- #########################################################################
    {
        "neovim/nvim-lspconfig",
        lazy = true,
        event = { "LazyFile" },
        version = false,
        dependencies = {
            { "folke/neodev.nvim", opts = {} },

            { "simrat39/rust-tools.nvim", opts = {} },

            {
                "pmizio/typescript-tools.nvim",
                dependencies = { "nvim-lua/plenary.nvim" },
                opts = {},
            },

            "williamboman/mason.nvim",
            {
                "williamboman/mason-lspconfig.nvim",
                dependencies = { "williamboman/mason.nvim" },
                opts = {},
            },
        },
        opts = function()
            local servers = require("plugins.lsp.servers")

            return {
                diagnostic = {
                    underline = true,
                    update_in_insert = false,
                    virtual_text = {
                        spacing = 4,
                        source = "if_many",
                        prefix = "icons",
                    },
                    severity_sort = true,
                },

                inlay_hints = {
                    enabled = true,
                },

                capabilities = {},

                servers = {
                    lua_ls = servers.lua_ls.opts,
                    rust_analyzer = servers.rust_analyzer.opts,
                    taplo = servers.taplo.opts,
                    tsserver = servers.tsserver.opts,
                },

                setup = {
                    rust_analyzer = servers.rust_analyzer.setup,
                    tsserver = servers.tsserver.setup,
                },
            }
        end,
        config = function(_, opts)
            local lspconfig = require("lspconfig")
            local lsp_keymaps = require("plugins.lsp.keymaps")

            -- Keymaps
            Util.lsp.on_attach(function(client, buffer)
                lsp_keymaps.on_attach(client, buffer)
            end)

            local register_capability =
                vim.lsp.handlers["client/registerCapability"]

            vim.lsp.handlers["client/registerCapability"] = function(
                err,
                res,
                ctx
            )
                local ret = register_capability(err, res, ctx)
                local client = vim.lsp.get_client_by_id(ctx.client_id)
                local buffer = vim.api.nvim_get_current_buf()
                lsp_keymaps.on_attach(client, buffer)

                return ret
            end

            -- Inlay Hints
            local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint

            if opts.inlay_hints.enabled and inlay_hint then
                Util.lsp.on_attach(function(client, buffer)
                    if client.supports_method("textDocument/inlayHint") then
                        inlay_hint(buffer, false)
                    end
                end)
            end

            -- Diagnostics
            for name, icon in pairs(require("config.icons").diagnostics) do
                name = "DiagnosticSign" .. name
                vim.fn.sign_define(
                    name,
                    { text = icon, texthl = name, numhl = "" }
                )
            end

            if
                type(opts.diagnostic.virtual_text) == "table"
                and opts.diagnostic.virtual_text.prefix == "icons"
            then
                opts.diagnostic.virtual_text.prefix = vim.fn.has("nvim-0.10.0")
                            == 0
                        and "●"
                    or function(diagnostic)
                        local icons = require("config.icons").diagnostics
                        for d, icon in pairs(icons) do
                            if
                                diagnostic.severity
                                == vim.diagnostic.severity[d:upper()]
                            then
                                return icon
                            end
                        end
                    end
            end

            vim.diagnostic.config(vim.deepcopy(opts.diagnostic))

            -- Setup Servers
            local servers = opts.servers
            local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                has_cmp and cmp_nvim_lsp.default_capabilities() or {},
                opts.capabilities or {}
            ) or {}

            local setup = function(server)
                local server_opts = vim.tbl_deep_extend("force", {
                    capabilities = vim.deepcopy(capabilities),
                }, servers[server] or {})

                if opts.setup[server] then
                    if opts.setup[server](server, server_opts) then
                        return
                    end
                elseif opts.setup["*"] then
                    if opts.setup["*"](server, server_opts) then
                        return
                    end
                end

                lspconfig[server].setup(server_opts)
            end

            local have_mason, mlsp = pcall(require, "mason-lspconfig")
            local all_mlsp_servers = {}
            if have_mason then
                all_mlsp_servers = vim.tbl_keys(
                    require("mason-lspconfig.mappings.server").lspconfig_to_package
                )
            end

            local ensure_installed = {}
            for server, server_opts in pairs(servers) do
                if server_opts then
                    server_opts = server_opts == true and {} or server_opts

                    if
                        server_opts.mason == false
                        or not vim.tbl_contains(all_mlsp_servers, server)
                    then
                        setup(server)
                    else
                        ensure_installed[#ensure_installed + 1] = server
                    end
                end
            end

            if have_mason then
                mlsp.setup({
                    ensure_installed = ensure_installed,
                    handlers = { setup },
                })
            end
        end,
    },
}
