local nnoremap = require("merlijn.keymap").nnoremap
local vnoremap = require("merlijn.keymap").vnoremap

require("gitsigns").setup({
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns
		local opts = { buffer = bufnr }

		nnoremap("]c", "&diff ? ']c' : ':Gitsigns next_hunk<CR>'", { expr = true, buffer = bufnr })
		nnoremap("[c", "&diff ? '[c' : ':Gitsigns prev_hunk<CR>'", { expr = true, buffer = bufnr })

		nnoremap("<leader>gsh", ":Gitsigns stage_hunk<CR>", opts)
		vnoremap("<leader>gsh", ":Gitsigns stage_hunk<CR>", opts)

		nnoremap("<leader>grh", ":Gitsigns reset_hunk<CR>", opts)
		vnoremap("<leader>grh", ":Gitsigns reset_hunk<CR>", opts)

		nnoremap("<leader>hR", gs.reset_buffer, opts)
		nnoremap("<leader>hp", gs.preview_hunk, opts)
	end,
})
