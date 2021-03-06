nnoremap <leader>ss :lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>si :lua require('telescope.builtin').live_grep{ search_dirs = { vim.fn.expand("%:p:h") ..  "/" .. vim.fn.expand("<cword>") } }<CR>
nnoremap <leader>fg :lua require('telescope.builtin').git_files()<CR>
nnoremap <leader>ff :lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>fi :lua require('telescope.builtin').find_files{ search_dirs = { vim.fn.expand("%:p:h") ..  "/" .. vim.fn.expand("<cword>") } }<CR>
nnoremap <leader>fb :lua require('telescope.builtin').oldfiles()<CR>
nnoremap <leader>fc :lua require('telescope.builtin').command_history()<CR>
nnoremap <leader>sw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>

nnoremap <leader>fd :lua require('merlijn.telescope').search_dotfiles()<CR>
