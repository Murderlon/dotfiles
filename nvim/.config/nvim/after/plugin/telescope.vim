nnoremap <leader>ss :lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>fg :lua require('telescope.builtin').git_files()<CR>
nnoremap <leader>ff :lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>fb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>fc :lua require('telescope.builtin').command_history()<CR>

nnoremap <leader>fd :lua require('merlijn.telescope').search_dotfiles()<CR>
