local cmp = require("cmp")
local ls = require("luasnip")
local lspkind = require("lspkind")

local confirm = cmp.mapping.confirm({
	behavior = cmp.ConfirmBehavior.Insert,
	select = true,
})
local confirm_copilot = cmp.mapping.confirm({
	select = true,
	behavior = cmp.ConfirmBehavior.Replace,
})

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.close(),
		["<c-space>"] = cmp.mapping.complete(),
		["<C-k>"] = function(...)
			local entry = cmp.get_selected_entry()
			if entry and entry.source.name == "copilot" then
				return confirm_copilot(...)
			end
			return confirm(...)
		end,
		["<C-l>"] = cmp.mapping(function(fallback)
			if ls.expand_or_jumpable() then
				ls.expand_or_jump()
			else
				fallback() -- The fallback function is treated as original mapped key.
			end
		end, { "i", "s" }),
		["<C-j>"] = cmp.mapping(function(fallback)
			if ls.jumpable(-1) then
				ls.jump(-1)
			else
				fallback() -- The fallback function is treated as original mapped key.
			end
		end, { "i", "s" }),
	}),
	sources = {
		-- The order of the sources matter, it determines priority in what to suggest
		{ name = "luasnip" },
		{ name = "copilot" },
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "nvim_lua" },
		{ name = "buffer", keyword_length = 3 },
	},
	snippet = {
		expand = function(args)
			ls.lsp_expand(args.body)
		end,
	},
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text",
			menu = {
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				luasnip = "[LuaSnip]",
				nvim_lua = "[Lua]",
				copilot = "[Copilot]",
			},
			maxwidth = 50,
		}),
	},
	experimental = {
		ghost_text = true,
	},
})

lspkind.init({ symbol_map = { Copilot = "" } })

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
