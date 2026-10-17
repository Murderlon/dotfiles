return {
  { "akinsho/bufferline.nvim", opts = { options = { mode = "tabs" } } },

  { "snacks.nvim", opts = { indent = { enabled = false } } },

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

  {
    "dmmulroy/tsc.nvim",
    opts = {
      use_trouble_qflist = true,
      auto_focus_qflist = true,
      auto_start_watch_mode = true,
      -- bin_path = "node_modules/.bin/tsc",
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
    dependencies = { "nvim-mini/mini.icons" },
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
      servers = {
        pyright = {
          settings = {
            python = {
              venvPath = ".",
              venv = ".venv",
            },
          },
        },
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- Install missing grammar when opening a file
      auto_install = true,
    },
  },

  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.json = { lsp_format = "never" }
      opts.formatters_by_ft.jsonc = { lsp_format = "never" }

      for _, ft in ipairs({ "markdown", "markdown.mdx" }) do
        opts.formatters_by_ft[ft] = vim.tbl_filter(function(formatter)
          return formatter ~= "markdownlint-cli2"
        end, opts.formatters_by_ft[ft] or {})
      end

      opts.formatters = vim.tbl_deep_extend("force", opts.formatters or {}, {
        oxfmt = {
          command = "oxfmt",
          args = { "--stdin-filepath", "$FILENAME" },
          stdin = true,
        },
      })
    end,
  },

  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.tbl_filter(function(tool)
        return tool ~= "markdownlint-cli2"
      end, opts.ensure_installed or {})
    end,
  },

  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}

      for _, ft in ipairs({ "markdown", "markdown.mdx" }) do
        opts.linters_by_ft[ft] = vim.tbl_filter(function(linter)
          return linter ~= "markdownlint-cli2"
        end, opts.linters_by_ft[ft] or {})
      end
    end,
  },
}
