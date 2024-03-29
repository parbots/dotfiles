---@class picklevim.util.whichkey
local M = {}

M.get_key_labels = function()
    local labels = {}

    -- Prefix
    local prefix_keys = "CM"
    local prefix_labels = {}
    prefix_labels["C"] = "CTRL"
    prefix_labels["M"] = "ALT"

    -- Key
    local keys =
        "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ`~!@#$%^&*()-_=+[{}]\\|;:'\",<.>/?"

    -- Operator
    local op_keys = { "cr", "CR", "Bslash", "BSlash", "bslash" }
    local op_labels = {}
    op_labels["CR"] = "RET"
    op_labels["BSLASH"] = "\\"

    local get_key = function(prefix, key)
        return "<" .. prefix .. "-" .. key .. ">"
    end

    local get_label = function(prefix_label, key_label)
        return prefix_label .. "-" .. key_label
    end

    -- Loop through prefix keys
    for prefix_key in string.gmatch(prefix_keys, ".") do
        local prefix_label = prefix_labels[prefix_key]
        local prefix_key_lower = string.lower(prefix_key)

        -- Loop through regular keys
        for key in string.gmatch(keys, ".") do
            local key_lower = string.lower(key)

            labels[get_key(prefix_key, key)] = get_label(prefix_label, key)
            labels[get_key(prefix_key_lower, key)] =
                get_label(prefix_label, key)
            labels[get_key(prefix_key, key_lower)] =
                get_label(prefix_label, key_lower)
            labels[get_key(prefix_key_lower, key_lower)] =
                get_label(prefix_label, key_lower)
        end

        -- Loop through operator keys
        for _, op_key in ipairs(op_keys) do
            local op_label = op_labels[string.upper(op_key)]

            labels[get_key(prefix_key, op_key)] =
                get_label(prefix_label, op_label)
        end
    end

    -- Add extra keys
    labels["<leader>"] = "LDR"
    labels["<Leader>"] = "LDR"

    labels["<space>"] = "SPC"
    labels["<Space>"] = "SPC"

    labels["<cr>"] = "RET"
    labels["<CR>"] = "RET"

    labels["<esc>"] = "ESC"
    labels["<Esc>"] = "ESC"

    labels["<tab>"] = "TAB"
    labels["<Tab>"] = "TAB"

    labels["<s-tab>"] = "S-TAB"
    labels["<S-Tab>"] = "S-TAB"

    return labels
end

M.operators = {
    v = "+visual mode",
    c = "+change",
    d = "+delete",
    y = "+yank",

    [">"] = "+indent right",
    ["<"] = "+indent left",
}

local motions = {
    general = {
        mappings = {
            -- Word
            w = "Move to Next Start (Word)",
            b = "Move to Previous Start (Word)",
            e = "Move to Next End (Word)",
            ["ge"] = "Move To Previous End (Word)",

            -- Char
            f = "Move to Next (Char)",
            F = "Move to Previous (Char)",
            t = "Move Before Next (Char)",
            T = "Move Before Previous (Char)",

            -- Line
            ["gg"] = "Goto First (Line)",
            G = "Goto Last (Line)",

            ["^"] = "Move to Non-Blank Start (Line)",
            ["0"] = "Move to Start (Line)",
            ["$"] = "Move to End (Line)",

            ["}"] = "Goto Next Empty (Line)",
            ["{"] = "Goto Previous Empty (Line)",

            ["%"] = "Matching '()', '{}', '[]' (Char)",
        },

        opts = {
            mode = { "n", "o" },
            prefix = "",
            silent = false,
            preset = true,
        },
    },

    inside = {
        mappings = {
            ["i"] = "+inside",

            ['i"'] = "Double Quotes",
            ["i'"] = "Single Quotes",
            ["i("] = "Block inside '(' to ')'",
            ["i)"] = "Block inside '(' to ')'",
            ["i<"] = "Block inside '<' to '>'",
            ["i>"] = "Block inside '<' to '>'",
            ["i["] = "Block inside '[' to ']'",
            ["i]"] = "Block inside '[' to ']'",
            ["i`"] = "Backticks",
            ["i{"] = "Block inside '{' to '}'",
            ["i}"] = "Block inside '{' to '}'",
            ["ib"] = "Block inside '[(' to ')]'",
            ["iB"] = "Block inside '[{' to '}]'",
            ["ii"] = "Object Scope",
            ["il"] = "Last Textobject",
            ["in"] = "Next Textobject",
            ["ip"] = "Paragraph",
            ["is"] = "Sentence",
            ["it"] = "Tag Block",
            ["iw"] = "Word",
            ["iW"] = "WORD",
        },

        opts = {
            mode = { "o" },
            prefix = "",
            silent = false,
            preset = true,
        },
    },

    around = {
        mappings = {
            ["a"] = "+around",

            ['a"'] = "Double Quotes",
            ["a'"] = "Single Quotes",
            ["a("] = "Block from '(' to ')'",
            ["a)"] = "Block from '(' to ')'",
            ["a<"] = "Block from '<' to '>'",
            ["a>"] = "Block from '<' to '>'",
            ["a["] = "Block from '[' to ']'",
            ["a]"] = "Block from '[' to ']'",
            ["a`"] = "Backticks",
            ["a{"] = "Block from '{' to '}'",
            ["a}"] = "Block from '{' to '}'",
            ["ab"] = "Block from '[(' to ')]'",
            ["aB"] = "Block from '[{' to '}]'",
            ["ai"] = "Object Scope",
            ["al"] = "Last Textobject",
            ["an"] = "Next Textobject",
            ["ap"] = "Paragraph",
            ["as"] = "Sentence",
            ["at"] = "Tag Block",
            ["aw"] = "Word",
            ["aW"] = "WORD",
        },

        opts = {
            mode = { "o" },
            prefix = "",
            silent = false,
            preset = true,
        },
    },
}

local groups = {
    builtin = {
        mappings = {
            ["v"] = { name = "+visual mode" },
            ["V"] = { name = "+visual line mode" },
            ["<C-V>"] = { name = "+visual block mode" },

            ["c"] = { name = "+change" },
            ["d"] = { name = "+delete" },
            ["y"] = { name = "+yank" },

            ["g"] = { name = "+goto" },

            ["["] = { name = "+previous" },
            ["]"] = { name = "+next" },

            [">"] = { name = "+indent right" },
            ["<"] = { name = "+indent left" },

            ["!"] = { name = "+filter through external program" },

            -- Leader
            ["<leader>"] = { name = "+leader" },
        },
        opts = {
            mode = { "n" },
            prefix = "",
            silent = false,
        },
    },

    leader = {
        mappings = {
            ["b"] = { name = "+buffer" },
            ["d"] = { name = "+delete" },
            ["f"] = {
                name = "+find/file",

                l = { name = "+lsp" },
            },
            ["g"] = { name = "+git" },
            ["l"] = { name = "+lsp" },
            ["o"] = { name = "+open" },
            ["s"] = {
                name = "+search/sort",

                n = { name = "+noice" },
            },
            ["t"] = {
                name = "+tab/trouble",

                l = { name = "+lsp" },
            },
            ["T"] = { name = "+treesitter" },
            ["w"] = { name = "+window/write" },
        },

        opts = {
            mode = { "n" },
            prefix = "<leader>",
            silent = false,
        },
    },
}

M.register_motions = function(whichkey)
    whichkey.register(motions.general.mappings, motions.general.opts)
    whichkey.register(motions.inside.mappings, motions.inside.opts)
    whichkey.register(motions.around.mappings, motions.around.opts)
end

M.register_groups = function(whichkey)
    whichkey.register(groups.builtin.mappings, groups.builtin.opts)
    whichkey.register(groups.leader.mappings, groups.leader.opts)
end

M.register = function()
    local whichkey = require("which-key")

    M.register_groups(whichkey)
    M.register_motions(whichkey)
end

return M
