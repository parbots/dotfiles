return {
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

            local keymap_util = require("util.keymap")
            keymap_util.map({
                -- Popups
                {
                    { "n" },
                    "<leader>Cv",
                    crates.show_versions_popup,
                    "Show crate versions",
                },
                {
                    { "n" },
                    "<leader>Cf",
                    crates.show_features_popup,
                    "Show crate features",
                },
                {
                    { "n" },
                    "<leader>Cd",
                    crates.show_dependencies_popup,
                    "Show crate dependencies",
                },

                -- Update crates
                {
                    { "n" },
                    "<leader>Cu",
                    crates.update_crate,
                    "Update crate",
                },
                {
                    { "v" },
                    "<leader>Cu",
                    crates.update_crates,
                    "Update selected crates",
                },
                {
                    { "n" },
                    "<leader>Ca",
                    crates.update_all_crates,
                    "Update all crates",
                },

                -- Upgrade Crates
                {
                    { "n" },
                    "<leader>CU",
                    crates.upgrade_crate,
                    "Upgrade crate",
                },
                {
                    { "v" },
                    "<leader>CU",
                    crates.upgrade_crates,
                    "Upgrade selected crates",
                },
                {
                    { "n" },
                    "<leader>CA",
                    crates.upgrade_all_crates,
                    "Upgrade all crates",
                },
            })
        end,
    },
}
