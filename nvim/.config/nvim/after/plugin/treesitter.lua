require("nvim-treesitter.install").compilers = { "gcc", "clang" }

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"bash",
		"cpp",
		"comment",
		"css",
		"scss",
		"graphql",
		"html",
		"javascript",
		"jsdoc",
		"json",
		"lua",
		"python",
		"regex",
		"tsx",
		"vue",
		"typescript",
		"fish",
		"svelte",
		"toml",
		"vim",
		"yaml",
		"php",
		"prisma",
		"gomod",
		"astro",
		"dockerfile",
	},
	highlight = { enable = true },
	incremental_selection = { enable = true },
	textobjects = { enable = true },
	indent = { enable = true },
})

require("treesitter-context").setup()