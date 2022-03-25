return require('packer').startup(function(use)
  -- General
  use 'wbthomason/packer.nvim'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'christoomey/vim-system-copy'
  use 'kyazdani42/nvim-web-devicons'

  -- Colorschemes
  use 'overcache/NeoSolarized'
  use 'bignimbus/pop-punk.vim'
  use 'folke/tokyonight.nvim'
  use 'wuelnerdotexe/vim-enfocado'
  use {
    'catppuccin/nvim',
    as = "catppuccin",
    branch = 'dev',
    config = function()
      require 'merlijn.config.catppuccin'
    end,
  }

  use {
    'folke/trouble.nvim',
    config = function()
      require 'merlijn.config.trouble'
    end,
  }

  -- Snippets
  use {
    'L3MON4D3/LuaSnip',
    config = function()
      require 'merlijn.config.luasnip'
    end,
  }

  -- File explorer
  use {
    'tamago324/lir.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require 'merlijn.config.lir'
    end,
  }

  -- Clipboard history
  use {
    'AckslD/nvim-neoclip.lua',
    config = function()
      require('neoclip').setup()
    end,
  }

  -- Comment commands
  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }

  -- Fast switching between active files
  use {
    'ThePrimeagen/harpoon',
    config = function ()
      require 'merlijn.config.harpoon'
    end
  }

  -- Formatting
  use {
    'sbdchd/neoformat',
    config = function ()
      require 'merlijn.config.neoformat'
    end
  }

  -- Search
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzy-native.nvim'
    },
    config = function ()
      require 'merlijn.config.telescope'
    end
  }
  use {
    'windwp/nvim-spectre',
    config = function()
      require 'merlijn.config.spectre'
    end,
  }

  -- Git
  use {
    'tpope/vim-fugitive',
    config = function ()
      require 'merlijn.config.fugitive'
    end
  }
  use {
    'lewis6991/gitsigns.nvim',
    config = function ()
      require 'merlijn.config.gitsigns'
    end
  }

  -- Language server
  use {
    'neovim/nvim-lspconfig',
    requires = { 'folke/lsp-colors.nvim' },
    config = function ()
      require 'merlijn.config.lsp'
    end
  }

  -- Completion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function ()
      require 'merlijn.config.cmp'
    end
  }

  -- Syntax
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function ()
      require 'merlijn.config.treesitter'
    end
  }
  use {
    'plasticboy/vim-markdown',
    config = function ()
      require 'merlijn.config.markdown'
    end
  }
end)
