local nnoremap = require("merlijn.keymap").nnoremap

nnoremap("<leader>ha", '<CMD>lua require("harpoon.mark").add_file()<CR>')
nnoremap("<leader>hq", '<CMD>lua require("harpoon.ui").toggle_quick_menu()<CR>')

nnoremap("<leader>h1", '<CMD>lua require("harpoon.ui").nav_file(1)<CR>')
nnoremap("<leader>h2", '<CMD>lua require("harpoon.ui").nav_file(2)<CR>')
nnoremap("<leader>h3", '<CMD>lua require("harpoon.ui").nav_file(3)<CR>')
nnoremap("<leader>h4", '<CMD>lua require("harpoon.ui").nav_file(4)<CR>')
nnoremap("<leader>h5", '<CMD>lua require("harpoon.ui").nav_file(5)<CR>')
nnoremap("<leader>h6", '<CMD>lua require("harpoon.ui").nav_file(6)<CR>')
nnoremap("<leader>h7", '<CMD>lua require("harpoon.ui").nav_file(7)<CR>')
nnoremap("<leader>h8", '<CMD>lua require("harpoon.ui").nav_file(8)<CR>')

nnoremap("<leader>t1", '<CMD>lua require("harpoon.term").gotoTerminal(1)<CR>')
nnoremap("<leader>t2", '<CMD>lua require("harpoon.term").gotoTerminal(2)<CR>')
