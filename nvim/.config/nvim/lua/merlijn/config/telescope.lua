local options = { noremap = true }
local map = vim.api.nvim_set_keymap
local M = {}

require('telescope').setup {
  defaults = {
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    prompt_prefix = '> ',
    selection_caret = '> ',
    file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = true,
      override_file_sorter = true,
    }
  },
  pickers = {
    git_files = { theme = 'ivy' },
    find_files = { theme = 'ivy' },
    live_grep = { theme = 'ivy' },
    buffers = { theme = 'ivy' },
    grep_string = { theme = 'ivy' },
  }
}

require('telescope').load_extension('fzy_native')
require('telescope').load_extension('neoclip')
require("telescope").load_extension "file_browser"

map('n', '<leader>ss', '<CMD>lua require("telescope.builtin").live_grep()<CR>', options)
map('n', '<leader>si', '<CMD>lua require("telescope.builtin").live_grep{ search_dirs = { <CMD>call nvim_feedkeys("Y", "n")<CR> } }<CR>', options)
map('n', '<leader>fg', '<CMD>lua require("telescope.builtin").git_files()<CR>', options)
map('n', '<leader>fm', '<CMD>Telescope file_browser<CR>', options)
map('n', '<leader>ff', '<CMD>lua require("telescope.builtin").find_files()<CR>', options)
map('n', '<leader>fi', '<CMD>lua require("telescope.builtin").find_files{ search_dirs = { vim.fn.expand("%:p:h") ..  "/" .. vim.fn.expand("<cword>") } }<CR>', options)
map('n', '<leader>fb', '<CMD>lua require("telescope.builtin").buffers()<CR>', options)
map('n', '<leader>fc', '<CMD>lua require("telescope.builtin").command_history()<CR>', options)
map('n', '<leader>fh', '<CMD>lua require("telescope.builtin").help_tags()<CR>', options)
map('n', '<leader>sw', '<CMD>lua require("telescope.builtin").grep_string { search = vim.fn.expand("<cword>") }<CR>', options)

map('n', '<leader>fd', '<CMD>lua require("merlijn.config.telescope").search_dotfiles()<CR>', options)

map('n', '<leader>yy', '<CMD>Telescope neoclip<CR>', options)

M.search_dotfiles = function()
  require("telescope.builtin").git_files({
    prompt_title = "Dotfiles",
    cwd = "$HOME/Dotfiles/",
  })
end

return M
