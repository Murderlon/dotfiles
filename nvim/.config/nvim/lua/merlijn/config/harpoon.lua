local map = vim.api.nvim_set_keymap
local options = { noremap = false }

map('n', '<leader>ha', '<CMD>lua require("harpoon.mark").add_file()<CR>', options)
map('n', '<leader>hq', '<CMD>lua require("harpoon.ui").toggle_quick_menu()<CR>', options)

map('n', '<leader>h1', '<CMD>lua require("harpoon.ui").nav_file(1)<CR>', options)
map('n', '<leader>h2', '<CMD>lua require("harpoon.ui").nav_file(2)<CR>', options)
map('n', '<leader>h3', '<CMD>lua require("harpoon.ui").nav_file(3)<CR>', options)
map('n', '<leader>h4', '<CMD>lua require("harpoon.ui").nav_file(4)<CR>', options)

map('n', '<leader>t1', '<CMD>lua require("harpoon.term").gotoTerminal(1)<CR>', options)
map('n', '<leader>t2', '<CMD>lua require("harpoon.term").gotoTerminal(2)<CR>', options)
map('n', '<leader>t3', '<CMD>lua require("harpoon.term").gotoTerminal(3)<CR>', options)
map('n', '<leader>t4', '<CMD>lua require("harpoon.term").gotoTerminal(4)<CR>', options)
