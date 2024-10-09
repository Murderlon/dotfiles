return {
  -- Extras
  { import = "lazyvim.plugins.extras.ui.treesitter-context" },

  { import = "lazyvim.plugins.extras.editor.harpoon2" },
  { import = "lazyvim.plugins.extras.editor.mini-files" },
  {
    "echasnovski/mini.files",
    lazy = false,
    opts = {
      options = {
        use_as_default_explorer = true,
      },
    },
  },

  { import = "lazyvim.plugins.extras.coding.luasnip" },
  { import = "lazyvim.plugins.extras.coding.mini-comment" },
  { import = "lazyvim.plugins.extras.coding.mini-surround" },

  { import = "lazyvim.plugins.extras.linting.eslint" },
  { import = "lazyvim.plugins.extras.formatting.prettier" },

  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.go" },
  { import = "lazyvim.plugins.extras.lang.tailwind" },
  { import = "lazyvim.plugins.extras.lang.yaml" },
  -- { import = "lazyvim.plugins.extras.lang.json" },

  -- Disable plugins
  { "echasnovski/mini.indentscope", enabled = false },
  { "echasnovski/mini.pairs", enabled = false },
  { "akinsho/bufferline.nvim", enabled = false },
  { "lukas-reineke/indent-blankline.nvim", enabled = false },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  { "folke/flash.nvim", enabled = false },

  {
    "dmmulroy/tsc.nvim",
    opts = {
      use_trouble_qflist = true,
      bin_path = "node_modules/.bin/tsc",
    },
  },

  -- Git
  { "akinsho/git-conflict.nvim", version = "*", opts = { default_mappings = false } },

  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- Install missing grammar when opening a file
      auto_install = true,
    },
  },
}
