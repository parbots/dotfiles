local Util = require("util")

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = Util.augroup("checktime"),
    command = "checktime",
})

-- Highlight on yank
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    group = Util.augroup("highlight_yank"),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
    group = Util.augroup("resize_splits"),
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd=")
        vim.cmd("tabnext " .. current_tab)
    end,
})

-- Go to last location when opening a buffer
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    group = Util.augroup("goto_last_location"),
    callback = function(event)
        local exclude = {
            "gitcommit",
        }

        local buffer = event.buf
        if
            vim.tbl_contains(exclude, vim.bo[buffer].filetype)
            or vim.b[buffer].picklevim_last_location
        then
            return
        end

        vim.b[buffer].picklevim_last_location = true

        local mark = vim.api.nvim_buf_get_mark(buffer, '"')
        local lcount = vim.api.nvim_buf_line_count(buffer)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd({ "FileType" }, {
    group = Util.augroup("close_with_q"),
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
            "Close (Autocmd)",
            { buffer = event.buf }
        )
    end,
})

-- Auto create directory when saving a file, in case some intermediate directory
-- does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = Util.augroup("auto_create_directory"),
    callback = function(event)
        if event.match:match("^%w%w+://") then
            return
        end

        local file = vim.loop.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})
