require("packer").startup(function(use)
	-- Package manager
	use("wbthomason/packer.nvim")

	-- Motions
	use("tpope/vim-surround")
	use("tpope/vim-repeat")

	-- Undo tree
	use("mbbill/undotree")

	-- Icons
	use("kyazdani42/nvim-web-devicons")

	-- Statusline
	use("nvim-lualine/lualine.nvim")

	-- Colorschemes
	use("folke/tokyonight.nvim")
	use("ellisonleao/gruvbox.nvim")
	use("wuelnerdotexe/vim-enfocado")
	use("ray-x/starry.nvim")
	use("ishan9299/nvim-solarized-lua")
	use({ "rose-pine/neovim", as = "rose-pine" })
	use({ "catppuccin/nvim", as = "catppuccin" })
	use({
		"uloco/bluloco.nvim",
		requires = { "rktjmp/lush.nvim" },
	})

	-- Snippets
	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets")

	-- File explorer
	use("tpope/vim-vinegar")

	-- Comment commands
	use("numToStr/Comment.nvim")

	-- Fast switching between active files
	use("ThePrimeagen/harpoon")

	-- Formatting
	use("sbdchd/neoformat")
	use("gpanders/editorconfig.nvim")

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
	use("benfowler/telescope-luasnip.nvim")
	use("nvim-pack/nvim-spectre")

	-- Git
	use("tpope/vim-fugitive")
	use("tpope/vim-rhubarb")
	use("lewis6991/gitsigns.nvim")
	use({ "sindrets/diffview.nvim", requires = { "nvim-lua/plenary.nvim" } })
	use({
		"akinsho/git-conflict.nvim",
		tag = "*",
		config = function()
			require("git-conflict").setup()
		end,
	})

	-- Language server / diagnostics
	use("neovim/nvim-lspconfig")
	use("folke/trouble.nvim")
	use("folke/lsp-colors.nvim")
	use("onsails/lspkind.nvim")
	use("j-hui/fidget.nvim")
	use({ "kosayoda/nvim-lightbulb", requires = "antoinemadec/FixCursorHold.nvim" })

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
	use({
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup()
		end,
	})
	use({
		"zbirenbaum/copilot-cmp",
		after = { "copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	})

	-- Syntax
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("nvim-treesitter/nvim-treesitter-context")
end)
