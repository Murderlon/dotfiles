local nnoremap = require("merlijn.keymap").nnoremap
local search_dotfiles = function()
	require("telescope.builtin").git_files({
		prompt_title = "Dotfiles",
		cwd = "$HOME/Dotfiles/",
	})
end

require("telescope").setup({
	defaults = {
		file_sorter = require("telescope.sorters").get_fzy_sorter,
		prompt_prefix = "> ",
		selection_caret = "> ",
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
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
		buffers = { theme = "ivy" },
		grep_string = { theme = "ivy" },
	},
})
require("telescope").load_extension("fzy_native")
require("telescope").load_extension("neoclip")
require("telescope").load_extension("file_browser")

nnoremap("<leader>ss", '<CMD>lua require("telescope.builtin").live_grep()<CR>')
nnoremap("<leader>fg", '<CMD>lua require("telescope.builtin").git_files()<CR>')
nnoremap("<leader>fm", "<CMD>Telescope file_browser<CR>")
nnoremap("<leader>ff", '<CMD>lua require("telescope.builtin").find_files()<CR>')
nnoremap("<leader>fb", '<CMD>lua require("telescope.builtin").buffers()<CR>')
nnoremap("<leader>fc", '<CMD>lua require("telescope.builtin").command_history()<CR>')
nnoremap("<leader>fh", '<CMD>lua require("telescope.builtin").help_tags()<CR>')
nnoremap("<leader>sw", '<CMD>lua require("telescope.builtin").grep_string { search = vim.fn.expand("<cword>") }<CR>')
nnoremap("<leader>fd", search_dotfiles)
nnoremap("<leader>yy", "<CMD>Telescope neoclip<CR>")
