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
  use 'tpope/vim-commentary'
  use 'tpope/vim-repeat'
  use 'svermeulen/vim-easyclip'
  use 'christoomey/vim-system-copy'

  use {
    'ThePrimeagen/harpoon',
    config = function ()
      require 'merlijn.config.harpoon'
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
      'creativenull/diagnosticls-configs-nvim'
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
  use 'nikvdp/ejs-syntax'

  -- Colorschemes
  use 'overcache/NeoSolarized'
  use 'bignimbus/pop-punk.vim'
  use 'folke/tokyonight.nvim'
end)
