local actions = require('telescope.actions')

require('telescope').setup {
    defaults = {
      file_sorter = require('telescope.sorters').get_fzy_sorter,
      prompt_prefix = '> ',
      selection_caret = '> ',
      color_devicons = true,
      file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
      grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
      qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = true,
        override_file_sorter = true,
      }
    }
}

require('telescope').load_extension('fzy_native')

require("telescope").load_extension("git_worktree")

local M = {}

M.search_dotfiles = function()
  require("telescope.builtin").git_files({
    prompt_title = "Dotfiles",
    cwd = "$HOME/Dotfiles/",
  })
end

return M
