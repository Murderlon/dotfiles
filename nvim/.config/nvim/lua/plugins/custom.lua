local Util = require("lazyvim.util")

return {
  -- Disable plugins
  { "echasnovski/mini.indentscope", enabled = false },
  { "echasnovski/mini.pairs", enabled = false },
  { "echasnovski/mini.surround", enabled = false },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  { "folke/noice.nvim", enabled = false },
  { "akinsho/bufferline.nvim", enabled = false },
  { "lukas-reineke/indent-blankline.nvim", enabled = false },
  { "RRethy/vim-illuminate", enabled = false },
  -- Colorschemes
  {
    "uloco/bluloco.nvim",
    lazy = false,
    priority = 1000,
    dependencies = { "rktjmp/lush.nvim" },
  },
  { "ellisonleao/gruvbox.nvim" },
  { "catppuccin/nvim", name = "catppuccin" },
  { "projekt0n/github-nvim-theme" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  { "tpope/vim-vinegar" },
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    keys = {
      { "<leader>gg", ":Git<CR>", desc = "Fugitive" },
      { "<leader>gb", ":Git blame<CR>", desc = "Git blame" },
      { "<leader>gc", ":Git commit<CR>", desc = "Git commit" },
    },
  },

  { "tpope/vim-rhubarb" },
  { "tpope/vim-surround" },
  {
    "ThePrimeagen/harpoon",
    config = function()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")
      local nnoremap = require("merlijn.keymap").nnoremap

      local function nav_file(n)
        return function()
          ui.nav_file(n)
        end
      end

      nnoremap("<leader>ha", mark.add_file)
      nnoremap("<leader>hq", ui.toggle_quick_menu)

      nnoremap("<leader>h1", nav_file(1))
      nnoremap("<leader>h2", nav_file(2))
      nnoremap("<leader>h3", nav_file(3))
      nnoremap("<leader>h4", nav_file(4))
      nnoremap("<leader>h5", nav_file(5))
      nnoremap("<leader>h6", nav_file(6))
      nnoremap("<leader>h7", nav_file(7))
      nnoremap("<leader>h8", nav_file(8))
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      local ls = require("luasnip")

      opts.mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.close(),
        ["<c-space>"] = cmp.mapping.complete(),
        ["<C-l>"] = cmp.mapping(function(fallback)
          if ls.expand_or_jumpable() then
            ls.expand_or_jump()
          else
            fallback() -- The fallback function is treated as original mapped key.
          end
        end, { "i", "s" }),
        ["<C-j>"] = cmp.mapping(function(fallback)
          if ls.jumpable(-1) then
            ls.jump(-1)
          else
            fallback() -- The fallback function is treated as original mapped key.
          end
        end, { "i", "s" }),
        ["<C-k>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        }),
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
        Util.telescope("git_files", { cwd = "$HOME/code/dotfiles" }),
        desc = "[F]ind [D]otfiles",
      },
      { "<leader><space>", Util.telescope("files", { cwd = false }), desc = "Find Files (root dir)" },
      { "<leader>ff", Util.telescope("files", { cwd = false }), desc = "Find Files (root dir)" },
      { "<leader>sg", Util.telescope("live_grep", { cwd = false }), desc = "Grep (root dir)" },
      { "<leader>sw", Util.telescope("grep_string", { cwd = false }), desc = "Word (root dir)" },
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

      local config = {
        options = {
          component_separators = "",
          section_separators = "",
          theme = "auto",
        },
        sections = {
          -- these are to remove the defaults
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          -- These will be filled later
          lualine_c = {},
          lualine_x = {},
        },
        inactive_sections = {
          lualine_c = {
            {
              "filename",
              path = 1,
              cond = conditions.buffer_not_empty,
              color = { gui = "bold" },
            },
          },
        },
      }

      -- Inserts a component in lualine_c at left section
      local function ins_left(component)
        table.insert(config.sections.lualine_c, component)
      end

      -- Inserts a component in lualine_x ot right section
      local function ins_right(component)
        table.insert(config.sections.lualine_x, component)
      end

      ins_left({
        "filename",
        path = 1,
        cond = conditions.buffer_not_empty,
      })

      ins_left({ "location" })

      ins_left({
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = {
          error = icons.diagnostics.Error,
          warn = icons.diagnostics.Warn,
          info = icons.diagnostics.Info,
          hint = icons.diagnostics.Hint,
        },
      })

      ins_left({
        function()
          return "%="
        end,
      })

      ins_right({
        "branch",
        icon = "",
      })

      ins_right({
        "diff",
        symbols = {
          added = icons.git.added,
          modified = icons.git.modified,
          removed = icons.git.removed,
        },
        cond = conditions.hide_in_width,
      })

      return config
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
  { "nvim-treesitter/nvim-treesitter-context", config = true },

  { "windwp/nvim-ts-autotag", config = true },
}
