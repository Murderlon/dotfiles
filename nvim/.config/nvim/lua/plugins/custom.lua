return {
  -- Disable plugins
  { "echasnovski/mini.indentscope", enabled = false },
  -- { "folke/noice.nvim", enabled = false },
  { "echasnovski/mini.pairs", enabled = false },
  { "echasnovski/mini.surround", enabled = false },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  { "akinsho/bufferline.nvim", enabled = false },
  -- { "lukas-reineke/indent-blankline.nvim", enabled = false },
  { "RRethy/vim-illuminate", enabled = false },
  -- Colorschemes
  { "ellisonleao/gruvbox.nvim", lazy = false },
  -- {
  --   "craftzdog/solarized-osaka.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {},
  --   config = function()
  --     require("solarized-osaka").setup({
  --       on_highlights = function(hl, c)
  --         hl["@parameter"] = { fg = c.base0 }
  --         hl["@property"] = { fg = c.base0 }
  --         hl["@keyword.function"] = { fg = c.blue500 }
  --       end,
  --       styles = {
  --         floats = "normal",
  --         sidebars = "normal",
  --       },
  --     })
  --   end,
  -- },
  -- { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  -- { "dasupradyumna/midnight.nvim", priority = 1000 },
  -- { "projekt0n/github-nvim-theme" },
  { "aktersnurra/no-clown-fiesta.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  { "tpope/vim-vinegar" },
  { "tpope/vim-surround" },
  { "akinsho/git-conflict.nvim", version = "*", opts = { default_mappings = false } },
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
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        -- This will not install any breaking changes.
        -- For major updates, this must be adjusted manually.
        version = "^1.0.0",
      },
    },
    config = function()
      require("telescope").load_extension("live_grep_args")
    end,
    keys = {
      {
        "<leader>fd",
        require("lazyvim.util").telescope("git_files", { cwd = "$HOME/code/dotfiles" }),
        desc = "[F]ind [D]otfiles",
      },
      {
        "<leader>fg",
        function()
          require("telescope").extensions.live_grep_args.live_grep_args()
        end,
        desc = "[F]ind [G]rep with args",
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local icons = require("lazyvim.config").icons
      local lualine = require("lualine")

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

      local function show_macro_recording()
        local recording_register = vim.fn.reg_recording()
        if recording_register == "" then
          return ""
        else
          return "Recording @" .. recording_register
        end
      end

      vim.api.nvim_create_autocmd("RecordingEnter", {
        callback = function()
          lualine.refresh({
            place = { "statusline" },
          })
        end,
      })

      vim.api.nvim_create_autocmd("RecordingLeave", {
        callback = function()
          -- Instead of just calling refresh we need to wait a moment because of the nature of
          -- `vim.fn.reg_recording`. If we tell lualine to refresh right now it actually will
          -- still show a recording occuring because `vim.fn.reg_recording` hasn't emptied yet.
          -- So what we need to do is wait a tiny amount of time (in this instance 50 ms) to
          -- ensure `vim.fn.reg_recording` is purged before asking lualine to refresh.
          local timer = vim.loop.new_timer()
          timer:start(
            50,
            0,
            vim.schedule_wrap(function()
              lualine.refresh({
                place = { "statusline" },
              })
            end)
          )
        end,
      })

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
              "macro-recording",
              fmt = show_macro_recording,
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
