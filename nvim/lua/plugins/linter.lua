return {
    "mfussenegger/nvim-lint",
    event = { "LazyFile" },
    opts = {
        linters_by_ft = {
            shell = { "shellcheck" },
            sh = { "shellcheck" },
            bash = { "shellcheck" },
            zsh = { "shellcheck" },
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
