local builtin = require("telescope.builtin")
local sorters = require("telescope.sorters")
local previewers = require("telescope.previewers")
local nnoremap = require("merlijn.keymap").nnoremap

local search_dotfiles = function()
	builtin.git_files({
		prompt_title = "Dotfiles",
		cwd = "$HOME/Dotfiles/",
	})
end

require("telescope").setup({
	defaults = {
		file_sorter = sorters.get_fzy_sorter,
		prompt_prefix = "> ",
		selection_caret = "> ",
		file_previewer = previewers.vim_buffer_cat.new,
		grep_previewer = previewers.vim_buffer_vimgrep.new,
		qflist_previewer = previewers.vim_buffer_qflist.new,
	},
	extensions = {
		fzy_native = {
			override_generic_sorter = true,
			override_file_sorter = true,
		},
	},
	pickers = {
		git_files = { theme = "ivy" },
		find_files = { theme = "ivy" },
		live_grep = { theme = "ivy" },
		old_files = { theme = "ivy" },
		grep_string = { theme = "ivy" },
		help_tags = { theme = "ivy" },
		lsp_references = { theme = "ivy" },
	},
})
require("telescope").load_extension("fzy_native")

nnoremap("<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
nnoremap("<leader>sf", function()
  -- `find_files` also supports a `hidden` option, but that would also show the `.git` folder.
  -- Instead we override the command to use `--hidden` and ignore the `.git` folder.
	builtin.find_files({ find_command = { "rg", "--files", "--hidden", "-g", "!.git" } })
end, { desc = "[S]earch [F]iles" })
nnoremap("<leader>?", builtin.oldfiles, { desc = "[?] Find recently opened files" })
nnoremap("<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
nnoremap("<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
nnoremap("<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
nnoremap("<leader>sc", search_dotfiles, { desc = "[S]earch dotfiles [C]onfig" })
