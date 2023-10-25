return {
    "mfussenegger/nvim-lint",
    event = { "LazyFile" },
    opts = {
        linters_by_ft = {
            zsh = { "shellcheck" },
            bash = { "shellcheck" },
            sh = { "shellcheck" },
        },
    },
    config = function(_, opts)
        local linter = require("lint")

        linter.linters_by_ft = opts.linters_by_ft

        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function()
                linter.try_lint()
            end,
        })
    end,
}
