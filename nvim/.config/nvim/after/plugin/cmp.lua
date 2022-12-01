local cmp = require("cmp")
local ls = require("luasnip")
local lspkind = require("lspkind")

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.close(),
		["<c-space>"] = cmp.mapping.complete(),
		["<C-k>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
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
	sources = cmp.config.sources({
		-- The order of the sources matter, it determines priority in what to suggest
		{ name = "path" },
    { name = "luasnip" },
		{ name = "nvim_lsp" },
    { name = "nvim_lua" }, -- only enabled in lua files
		{ name = "buffer", keyword_length = 4 },
	}),
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
			},
			maxwidth = 50,
		}),
	},
	experimental = {
		ghost_text = true,
	},
})
