vim.g.mapleader = ' '

-- Never use 'Q'
vim.keymap.set('n', 'Q', '<nop>')

-- Easily exit insert mode
vim.keymap.set('i', 'jj', '<ESC>', { noremap = true, desc = 'Exit insert mode' })
vim.keymap.set('i', 'jk', '<ESC>', { noremap = true, desc = 'Exit insert mode' })
vim.keymap.set('i', 'kj', '<ESC>', { noremap = true, desc = 'Exit insert mode' })

-- Quick saving
vim.keymap.set('n', 'zz', ':w<CR>', { desc = 'Save file' })

-- Quick source current file
vim.keymap.set('n', '<leader><leader>', ':so<CR>', { desc = 'Source current file' })

-- Quick buffer delete
vim.keymap.set('n', '<leader>bd', ':bd<CR>', { desc = 'Delete current buffer' })

-- Better block selection movemenJ`zJJJ`J`z
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected block up' })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected block down' })

-- Easy append in place
vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Append in place' })

-- Faster up and down movement
vim.keymap.set('n', 'C-u', '<C-u>zz', { desc = 'Move up half page' })
vim.keymap.set('n', 'C-d', '<C-d>zz', { desc = 'Move down half page' })

-- Better next and previous search
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Put without changing the registers
vim.keymap.set('x', '<leader>p', '"_dP')

-- Remove without changing the registers
vim.keymap.set({ 'n', 'x' }, 'x', '"_x')

-- Select all
vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>')

-- Quick copy to system clipboard
vim.keymap.set('n', '<leader>y', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set('n', '<leader>Y', '"+Y', { desc = 'Copy to system clipboard' })

-- Better search and replace word
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = 'Search and replace current word' })

-- Quick formatting
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = 'Format current buffer with lsp' })

-- Easily open netrw
--vim.keymap.set('n', '<leader>ff', vim.cmd.Ex, { desc = 'Open netrw' })

-- Netrw mappings
vim.api.nvim_create_autocmd('filetype', {
    pattern = 'netrw',
    desc = 'Better mappings for netrw',
    callback = function()
        vim.keymap.set('n', 'n', '%', { remap = true, buffer = true, desc = 'Create new file' })
    end
})
