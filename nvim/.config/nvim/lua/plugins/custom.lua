return {
  -- Disable plugins
  { "echasnovski/mini.indentscope", enabled = false },
  { "folke/noice.nvim", enabled = false },
  { "echasnovski/mini.pairs", enabled = false },
  { "echasnovski/mini.surround", enabled = false },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  { "akinsho/bufferline.nvim", enabled = false },
  { "lukas-reineke/indent-blankline.nvim", enabled = false },
  { "RRethy/vim-illuminate", enabled = false },
  -- Colorschemes
  -- {
  --   "uloco/bluloco.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   dependencies = { "rktjmp/lush.nvim" },
  -- },
  -- { "ellisonleao/gruvbox.nvim" },
  -- { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  -- { "dasupradyumna/midnight.nvim", priority = 1000 },
  -- { "projekt0n/github-nvim-theme" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },

  { "tpope/vim-vinegar" },
  { "tpope/vim-surround" },
  { "akinsho/git-conflict.nvim", version = "*", config = { default_mappings = false } },
  { "ruifm/gitlinker.nvim", config = true },
  {
    "ThePrimeagen/harpoon",
    keys = function()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")

      local function nav_file(n)
        return function()
          ui.nav_file(n)
        end
      end

      return {
        { "<leader>ha", mark.add_file, desc = "Add file to harpoon" },
        { "<leader>hq", ui.toggle_quick_menu, desc = "Harpoon quick menu" },
        { "<leader>h1", nav_file(1), desc = "Harpoon file 1" },
        { "<leader>h2", nav_file(2), desc = "Harpoon file 2" },
        { "<leader>h3", nav_file(3), desc = "Harpoon file 3" },
        { "<leader>h4", nav_file(4), desc = "Harpoon file 4" },
        { "<leader>h5", nav_file(5), desc = "Harpoon file 5" },
        { "<leader>h6", nav_file(6), desc = "Harpoon file 6" },
        { "<leader>h7", nav_file(7), desc = "Harpoon file 7" },
        { "<leader>h8", nav_file(8), desc = "Harpoon file 8" },
      }
    end,
  },

  {
    "sourcegraph/sg.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>cc", "<CMD>CodyToggle<CR>", desc = "[C]ody" },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")

      opts.mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.close(),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-k>"] = cmp.mapping.confirm({ select = true }),
      })
    end,
  },

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "arch -arm64 make",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>fd",
        require("lazyvim.util").telescope("git_files", { cwd = "$HOME/code/dotfiles" }),
        desc = "[F]ind [D]otfiles",
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local icons = require("lazyvim.config").icons

      local conditions = {
        buffer_not_empty = function()
          return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
        end,
        hide_in_width = function()
          return vim.fn.winwidth(0) > 80
        end,
        check_git_workspace = function()
          local filepath = vim.fn.expand("%:p:h")
          local gitdir = vim.fn.finddir(".git", filepath .. ";")
          return gitdir and #gitdir > 0 and #gitdir < #filepath
        end,
      }

      return {
        options = {
          component_separators = "",
          section_separators = "",
          theme = "auto",
        },
        sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {
            {
              "filename",
              path = 1,
              cond = conditions.buffer_not_empty,
            },
            { "location" },
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            {
              function()
                return "%="
              end,
            },
          },
          lualine_x = {
            {
              "branch",
              icon = "",
            },

            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
              cond = conditions.hide_in_width,
            },
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_x = {},
          lualine_c = {
            {
              "filename",
              path = 1,
              cond = conditions.buffer_not_empty,
            },
            { "location" },
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
          },
        },
      }
    end,
  },

  { "nvim-pack/nvim-spectre", opts = { replace_engine = { sed = { cmd = "sed" } } } },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "astro",
        "bash",
        "comment",
        "cpp",
        "css",
        "dockerfile",
        "fish",
        "go",
        "gomod",
        "gosum",
        "graphql",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "php",
        "prisma",
        "python",
        "regex",
        "scss",
        "svelte",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vue",
        "yaml",
      },
    },
  },
}
