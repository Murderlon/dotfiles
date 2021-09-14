nnoremap <leader>ha :lua require("harpoon.mark").add_file()<CR>
nnoremap <leader>hq :lua require("harpoon.ui").toggle_quick_menu()<CR>

nnoremap <leader>h1 :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <leader>h2 :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <leader>h3 :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <leader>h4 :lua require("harpoon.ui").nav_file(4)<CR>

nnoremap <leader>t1 :lua require("harpoon.term").gotoTerminal(1)<CR>
nnoremap <leader>t2 :lua require("harpoon.term").gotoTerminal(2)<CR>
nnoremap <leader>t3 :lua require("harpoon.term").gotoTerminal(3)<CR>
nnoremap <leader>t4 :lua require("harpoon.term").gotoTerminal(4)<CR>
