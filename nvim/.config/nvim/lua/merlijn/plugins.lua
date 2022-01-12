local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  -- General
  use 'tpope/vim-vinegar'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'christoomey/vim-system-copy'
  use 'kyazdani42/nvim-web-devicons'

  use {
    'windwp/nvim-spectre',
    config = function()
      require 'merlijn.config.spectre'
    end,
  }

  use {
    'AckslD/nvim-neoclip.lua',
    config = function()
      require('neoclip').setup()
    end,
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }

  use {
    'ThePrimeagen/harpoon',
    config = function ()
      require 'merlijn.config.harpoon'
    end
  }

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

  -- Snippets
  use 'SirVer/ultisnips'
  use 'honza/vim-snippets'
  use 'mlaursen/vim-react-snippets'

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
      require('gitsigns').setup()
    end
  }

  -- Language server
  use {
    'neovim/nvim-lspconfig',
    requires = {
      'creativenull/diagnosticls-configs-nvim',
      'folke/lsp-colors.nvim'
    },
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
      'quangnguyen30192/cmp-nvim-ultisnips'
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

  -- Colorschemes
  use 'overcache/NeoSolarized'
  use 'bignimbus/pop-punk.vim'
  use 'folke/tokyonight.nvim'
  use 'tjdevries/colorbuddy.vim'
  use 'tjdevries/gruvbuddy.nvim'
end)
