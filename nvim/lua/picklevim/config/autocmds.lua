local Util = require("picklevim.util")

-- Auto create directory when saving a file, in case some intermediate directory
-- does not exist
Util.autocmd({
    group = "auto_mkdir",
    event = "BufWritePre",
    opts = {
        callback = function(event)
            if event.match:match("^%w%w+://") then
                return
            end

            local file = vim.loop.fs_realpath(event.match) or event.match
            vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
        end,
    },
})

-- Check buffers for outside changes
Util.autocmd({
    group = "checktime",
    event = { "FocusGained", "TermClose", "TermLeave" },
    opts = {
        command = "checktime",
    },
})

-- Go to last location when opening a buffer
Util.autocmd({
    group = "goto_last_loc",
    event = "BufReadPost",
    opts = {
        callback = function(event)
            local excluded_filetypes = {
                "gitcommit",
            }

            local buffer = event.buf
            if
                vim.tbl_contains(excluded_filetypes, vim.bo[buffer].filetype)
                or vim.b[buffer].picklevim_last_loc
            then
                return
            end

            local mark_pos = vim.api.nvim_buf_get_mark(buffer, '"')
            local line_count = vim.api.nvim_buf_line_count(buffer)
            if mark_pos[1] > 0 and mark_pos[1] <= line_count then
                pcall(vim.api.nvim_win_set_cursor, 0, mark_pos)
            end

            vim.b[buffer].picklevim_last_loc = true
        end,
    },
})

-- Highlight yanked text area
Util.autocmd({
    group = "highlight_yank",
    event = "TextYankPost",
    opts = {
        callback = function()
            vim.highlight.on_yank()
        end,
    },
})

-- Close some filetypes with <q>
Util.autocmd({
    group = "quick_close",
    event = "FileType",
    opts = {
        pattern = {
            "checkhealth",
            "help",
            "lspinfo",
            "man",
            "notify",
            "oil",
            "PlenaryTestPopup",
            "qf",
            "query",
            "spectre_panel",
            "startuptime",
            "trouble",
            "tsplayground",
        },
        callback = function(event)
            vim.bo[event.buf].buflisted = false

            Util.keymap.set(
                { "n" },
                "q",
                "<cmd> close <cr>",
                { desc = "Close (Autocmd)", buffer = event.buf }
            )
        end,
    },
})

-- Resize splits if window got resized
Util.autocmd({
    group = "resize_splits",
    event = "VimResized",
    opts = {
        callback = function()
            local current_tab = vim.fn.tabpagenr()
            vim.cmd("tabdo wincmd=")
            vim.cmd("tabnext " .. current_tab)
        end,
    },
})
