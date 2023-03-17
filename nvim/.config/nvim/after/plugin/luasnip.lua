local ls = require("luasnip")

ls.config.set_config({
	-- This tells LuaSnip to remember to keep around the last snippet.
	-- You can jump back into it even if you move outside of the selection
	history = true,
	-- This one is cool cause if you have dynamic snippets, it updates as you type!
	updateevents = "TextChanged,TextChangedI",
	enable_autosnippets = true,
})
ls.filetype_extend("mdx", { "markdown" })

require("luasnip.loaders.from_vscode").lazy_load()
