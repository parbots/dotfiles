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

            local keymap_util = require("picklevim.util.keymap")
            keymap_util.map({
                -- Popups
                {
                    { "n" },
                    "<leader>Cv",
                    crates.show_versions_popup,
                    { desc = "Show crate versions" },
                },
                {
                    { "n" },
                    "<leader>Cf",
                    crates.show_features_popup,
                    { desc = "Show crate features" },
                },
                {
                    { "n" },
                    "<leader>Cd",
                    crates.show_dependencies_popup,
                    { desc = "Show crate dependencies" },
                },

                -- Update crates
                {
                    { "n" },
                    "<leader>Cu",
                    crates.update_crate,
                    { desc = "Update crate" },
                },
                {
                    { "v" },
                    "<leader>Cu",
                    crates.update_crates,
                    { desc = "Update selected crates" },
                },
                {
                    { "n" },
                    "<leader>Ca",
                    crates.update_all_crates,
                    { desc = "Update all crates" },
                },

                -- Upgrade Crates
                {
                    { "n" },
                    "<leader>CU",
                    crates.upgrade_crate,
                    { desc = "Upgrade crate" },
                },
                {
                    { "v" },
                    "<leader>CU",
                    crates.upgrade_crates,
                    { desc = "Upgrade selected crates" },
                },
                {
                    { "n" },
                    "<leader>CA",
                    crates.upgrade_all_crates,
                    { desc = "Upgrade all crates" },
                },
            })
        end,
    },
}
