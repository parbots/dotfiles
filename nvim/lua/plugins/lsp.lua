return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            { 'williamboman/mason.nvim' }, -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' }, -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'hrsh7th/cmp-buffer' }, -- Optional
            { 'hrsh7th/cmp-path' }, -- Optional
            { 'saadparwaiz1/cmp_luasnip' }, -- Optional
            { 'hrsh7th/cmp-nvim-lua' }, -- Optional

            -- Snippets
            { 'L3MON4D3/LuaSnip' }, -- Required
            { 'rafamadriz/friendly-snippets' }, -- Optional
        },
        config = function()
            local lsp = require('lsp-zero').preset({
                suggest_lsp_servers = true,
                setup_servers_on_start = true,
                set_lsp_keymaps = true,
                configure_diagnostics = true,
                cmp_capabilities = true,
                manage_nvim_cmp = true,
                call_servers = 'local',
                sign_icons = { error = 'E', warn = 'W', hint = 'H', info = 'I' }
            })

            require('luasnip').filetype_extend('javascript', { 'javascriptreact' })
            require('luasnip').filetype_extend('javascript', { 'html' })
            require('luasnip').filetype_extend('javascriptreact', { 'html' })
            require('luasnip').filetype_extend('typescriptreact', { 'html' })

            require('luasnip.loaders.from_vscode').lazy_load()

            lsp.setup_nvim_cmp({
                sources = {
                    { name = 'path' }, { name = 'nvim_lsp' },
                    { name = 'buffer',  keyword_length = 3 },
                    { name = 'luasnip', keyword_length = 2 }
                }
            })

            lsp.configure('lua_ls', {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' }
                        }
                    }
                }
            })

            lsp.configure('lua-language-server', {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' }
                        }
                    }
                }
            })

            lsp.configure('selene', {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' }
                        }
                    }
                }
            })

            lsp.nvim_workspace()

            lsp.setup()

            vim.diagnostic.config({ virtual_text = true })
        end
    }, { 'j-hui/fidget.nvim', config = function() require('fidget').setup() end }
}
