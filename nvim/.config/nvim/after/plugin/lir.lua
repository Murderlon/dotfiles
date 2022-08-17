local actions = require("lir.actions")
local clipboard_actions = require("lir.clipboard.actions")
local nnoremap = require("merlijn.keymap").nnoremap

-- Open lir like netrw with vinegar or dirvish
nnoremap("-", [[<Cmd>execute 'e ' .. expand('%:p:h')<CR>]])

require("lir").setup({
	show_hidden_files = true,
	devicons_enable = true,
	float = { winblend = 0 },
	hide_cursor = false,
	mappings = {
		["<CR>"] = actions.edit,
		["-"] = actions.up,

		["<C-s>"] = actions.split,
		["<C-v>"] = actions.vsplit,
		["<C-t>"] = actions.tabedit,

		["q"] = actions.quit,

		["d"] = actions.mkdir,
		["N"] = actions.newfile,
		["R"] = actions.rename,
		["Y"] = actions.yank_path,
		["."] = actions.toggle_show_hidden,
		["D"] = actions.delete,

		["C"] = clipboard_actions.copy,
		["X"] = clipboard_actions.cut,
		["P"] = clipboard_actions.paste,
	},
})
