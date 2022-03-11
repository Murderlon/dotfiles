local options = { noremap = true }
local map = vim.api.nvim_set_keymap

vim.g.mapleader = " "

map('n', '<leader>w', '<CMD>w!<CR>', options)
map('n', '<leader><cr>', '<CMD>noh<CR>', options) -- Disable highlight when <leader><cr> is pressed
map('n', '<leader>q', '<CMD>bd<CR>', options) -- Close buffer
map('n', '<leader>ba', '<CMD>bufdo bd<CR>', options) -- Close all buffers

-- Smart way to move between windows
map('n', '<C-j>', '<C-W>j', options)
map('n', '<C-k>', '<C-W>k', options)
map('n', '<C-h>', '<C-W>h', options)
map('n', '<C-l>', '<C-W>l', options)

-- Moving lines with Alt-j / Alt-k
-- https://stackoverflow.com/a/15399297/10798093
map('n', '∆', ':m .+1<CR>==', options)
map('n', '˚', ':m .-2<CR>==', options)

map('i', '∆', '<Esc>:m .+1<CR>==gi', options)
map('i', '˚', '<Esc>:m .-2<CR>==gi', options)

map('v', '∆', ":m '>+1<CR>gv=gv", options)
map('v', '˚', ":m '<-2<CR>gv=gv", options)

-- Move visual block
map('v', 'J', ":m '>+1<CR>gv=gv", options)
map('v', 'K', ":m '<-2<CR>gv=gv", options)

-- Re-select visual block after indenting
map('v', '<', '<gv', options)
map('v', '>', '>gv', options)

-- Keep search matches in the middle of the screen
map('n', 'n', 'nzz', options)
map('n', 'N', 'Nzz', options)
