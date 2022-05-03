local map = vim.api.nvim_set_keymap
local options = { noremap = false }

map('n', '<leader>ha', '<CMD>lua require("harpoon.mark").add_file()<CR>', options)
map('n', '<leader>hq', '<CMD>lua require("harpoon.ui").toggle_quick_menu()<CR>', options)

map('n', '<leader>h1', '<CMD>lua require("harpoon.ui").nav_file(1)<CR>', options)
map('n', '<leader>h2', '<CMD>lua require("harpoon.ui").nav_file(2)<CR>', options)
map('n', '<leader>h3', '<CMD>lua require("harpoon.ui").nav_file(3)<CR>', options)
map('n', '<leader>h4', '<CMD>lua require("harpoon.ui").nav_file(4)<CR>', options)
map('n', '<leader>h5', '<CMD>lua require("harpoon.ui").nav_file(5)<CR>', options)
map('n', '<leader>h6', '<CMD>lua require("harpoon.ui").nav_file(6)<CR>', options)
map('n', '<leader>h7', '<CMD>lua require("harpoon.ui").nav_file(7)<CR>', options)
map('n', '<leader>h8', '<CMD>lua require("harpoon.ui").nav_file(8)<CR>', options)
