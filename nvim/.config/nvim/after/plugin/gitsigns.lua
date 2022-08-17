require("gitsigns").setup({
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map("n", "]c", "&diff ? ']c' : '<CMD>Gitsigns next_hunk<CR>'", { expr = true })
		map("n", "[c", "&diff ? '[c' : '<CMD>Gitsigns prev_hunk<CR>'", { expr = true })

		-- Actions
		map({ "n", "v" }, "<leader>gsh", "<CMD>Gitsigns stage_hunk<CR>")
		map({ "n", "v" }, "<leader>grh", "<CMD>Gitsigns reset_hunk<CR>")
		map("n", "<leader>hR", gs.reset_buffer)
		map("n", "<leader>hp", gs.preview_hunk)
	end,
})
