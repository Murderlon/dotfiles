return {
  -- Disable plugins
  { "echasnovski/mini.pairs", enabled = false },
  { "akinsho/bufferline.nvim", enabled = false },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  { "folke/flash.nvim", enabled = false },

  -- Extras
  { import = "lazyvim.plugins.extras.editor.harpoon2" },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    opts = function()
      local harpoon = require("harpoon")

      harpoon:extend({
        UI_CREATE = function(cx)
          vim.keymap.set("n", "<C-v>", function()
            harpoon.ui:select_menu_item({ vsplit = true })
          end, { buffer = cx.bufnr })

          vim.keymap.set("n", "<C-x>", function()
            harpoon.ui:select_menu_item({ split = true })
          end, { buffer = cx.bufnr })

          vim.keymap.set("n", "<C-t>", function()
            harpoon.ui:select_menu_item({ tabedit = true })
          end, { buffer = cx.bufnr })
        end,
      })
    end,
  },

  { import = "lazyvim.plugins.extras.coding.luasnip" },
  { import = "lazyvim.plugins.extras.coding.mini-comment" },
  { import = "lazyvim.plugins.extras.coding.mini-surround" },

  -- { import = "lazyvim.plugins.extras.ui.treesitter-context" },

  -- { import = "lazyvim.plugins.extras.ai.copilot" },
  -- { import = "lazyvim.plugins.extras.ai.copilot-chat" },

  { import = "lazyvim.plugins.extras.linting.eslint" },
  { import = "lazyvim.plugins.extras.formatting.prettier" },
  { import = "lazyvim.plugins.extras.formatting.biome" },

  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.go" },
  { import = "lazyvim.plugins.extras.lang.rust" },
  { import = "lazyvim.plugins.extras.lang.tailwind" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.php" },

  {
    "dmmulroy/tsc.nvim",
    opts = {
      use_trouble_qflist = true,
      auto_focus_qflist = true,
      auto_start_watch_mode = true,
      bin_path = "node_modules/.bin/tsc",
    },
  },

  {
    "stevearc/oil.nvim",
    lazy = false,
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name)
          if name:match(".DS_Store") then
            return true
          end
          return false
        end,
      },
    },
    dependencies = { "echasnovski/mini.icons" },
    keys = {
      {
        "-",
        "<CMD>Oil<CR>",
        desc = "Open parent directory",
      },
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
