local map = vim.api.nvim_set_keymap
local options = { noremap = false }

map('n', '<leader>gg', '<CMD>Git<CR>', options)
map('n', '<leader>gc', '<CMD>Git commit<CR>', options)
map('n', '<leader>gp', '<CMD>Git push<CR>', options)
map('n', '<leader>gb', '<CMD>Git blame<CR>', options)
