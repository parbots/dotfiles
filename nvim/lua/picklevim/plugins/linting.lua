return {
    "mfussenegger/nvim-lint",
    event = { "LazyFile" },
    opts = {
        events = { "BufWritePost", "BufReadPost", "InsertLeave" },

        linters_by_ft = {
            zsh = { "shellcheck" },
            bash = { "shellcheck" },
            sh = { "shellcheck" },
        },

        ---@type table<string, table>
        linters = {},
    },
    config = function(_, opts)
        local Util = require("picklevim.util")

        local M = {}

        local lint = require("lint")
        for name, linter in pairs(opts.linters) do
            if
                type(lint.linters[name]) == "table"
                and type(linter) == "table"
            then
                lint.linters[name] =
                    ---@diagnostic disable-next-line: param-type-mismatch
                    vim.tbl_deep_extend("force", lint.linters[name], linter)
            else
                lint.linters[name] = linter
            end
        end

        lint.linters_by_ft = opts.linters_by_ft

        M.debounce = function(ms, fn)
            local timer = vim.loop.new_timer() or {}
            return function(...)
                local argv = { ... }

                timer:start(ms, 0, function()
                    timer:stop()
                    vim.schedule_wrap(fn)(unpack(argv))
                end)
            end
        end

        M.lint = function()
            local names = lint._resolve_linter_by_ft(vim.bo.filetype)

            -- Add fallback linters
            if #names == 0 then
                vim.list_extend(names, lint.linters_by_ft["_"] or {})
            end

            -- Add global linters
            vim.list_extend(names, lint.linters_by_ft["*"] or {})

            -- Filter out linters that don't exist or don't match the condition
            local ctx = { filename = vim.api.nvim_buf_get_name(0) }
            ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
            names = vim.tbl_filter(function(name)
                local linter = lint.linters[name]
                if not linter then
                    Util.lazy.warn(
                        "Linter not found: " .. name,
                        { title = "nvim-lint" }
                    )
                end

                return linter
                    and not (
                        type(linter) == "table"
                        ---@diagnostic disable-next-line undefined-field
                        and linter.condition
                        ---@diagnostic disable-next-line undefined-field
                        and not linter.condition(ctx)
                    )
            end, names)

            -- Run linters
            if #names > 0 then
                lint.try_lint(names)
            end
        end

        Util.autocmd({
            group = "nvim-lint",
            event = opts.events,
            opts = {
                callback = M.debounce(100, M.lint),
            },
        })
    end,
}
