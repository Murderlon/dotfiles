-- Disable netrw for lir.nvim
-- Needs to live here to prevent startup error
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return require("packer").startup(function(use)
	-- General
	use("wbthomason/packer.nvim")
	use("tpope/vim-surround")
	use("tpope/vim-repeat")
	use("christoomey/vim-system-copy")
	use("kyazdani42/nvim-web-devicons")

	-- Colorschemes
	use("bignimbus/pop-punk.vim")
	use("folke/tokyonight.nvim")
	use("ellisonleao/gruvbox.nvim")
	use("wuelnerdotexe/vim-enfocado")
	use("ray-x/starry.nvim")
	use("projekt0n/github-nvim-theme")

	-- Snippets
	use("L3MON4D3/LuaSnip")

	-- File explorer
	use({
		"tamago324/lir.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	})

	-- Clipboard history
	use("AckslD/nvim-neoclip.lua")

	-- Comment commands
	use("numToStr/Comment.nvim")

	-- Fast switching between active files
	use("ThePrimeagen/harpoon")

	-- Formatting
	use("sbdchd/neoformat")

	-- Search
	use({
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		requires = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzy-native.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
		},
	})
	use("windwp/nvim-spectre")

	-- Git
	use("tpope/vim-fugitive")
	use("lewis6991/gitsigns.nvim")
	use({
		"sindrets/diffview.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("diffview").setup({})
		end,
	})

	-- Language server / diagnostics
	use({
		"neovim/nvim-lspconfig",
		requires = { "folke/lsp-colors.nvim" },
	})
	use({
		"fatih/vim-go",
		run = ":GoUpdateBinaries",
	})
	use("folke/trouble.nvim")

	-- Completion
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
		},
	})

	-- Syntax
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("plasticboy/vim-markdown")
end)
