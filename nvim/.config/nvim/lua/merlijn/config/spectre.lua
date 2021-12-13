local map = vim.api.nvim_set_keymap
local options = { noremap = false }

map('n', '<leader>S', '<CMD>lua require("spectre").open()<CR>', options)
map('n', '<leader>sp', '<CMD>lua require("spectre").open_file_search()<CR>', options)
