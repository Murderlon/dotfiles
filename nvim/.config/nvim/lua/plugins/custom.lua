return {
  -- Disable plugins
  { "echasnovski/mini.indentscope", enabled = false },
  { "echasnovski/mini.pairs", enabled = false },
  { "echasnovski/mini.surround", enabled = false },
  { "akinsho/bufferline.nvim", enabled = false },
  { "lukas-reineke/indent-blankline.nvim", enabled = false },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  { "folke/flash.nvim", enabled = false },

  -- Colorschemes
  -- { "ellisonleao/gruvbox.nvim", opts = { bold = false } },
  -- { "dasupradyumna/midnight.nvim" },
  -- { "projekt0n/github-nvim-theme" },
  -- { "aktersnurra/no-clown-fiesta.nvim" },
  -- { "ishan9299/nvim-solarized-lua" },
  -- { "rose-pine/neovim", name = "rose-pine", opts = { styles = { italic = false } } },
  -- { "ramojus/mellifluous.nvim" },
  -- { "EdenEast/nightfox.nvim" },
  -- { "catppuccin/nvim", name = "catppuccin", opts = { flavour = "macchiato" } },
  -- {
  --   "uloco/bluloco.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   dependencies = { "rktjmp/lush.nvim" },
  --   config = true,
  -- },
  -- {
  --   "slugbyte/lackluster.nvim",
  --   lazy = false,
  --   priority = 1000,
  -- },
  -- {
  --   "ishan9299/nvim-solarized-lua",
  --   lazy = false,
  --   priority = 1000,
  -- },
  -- {
  --   "AlexvZyl/nordic.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("nordic").load()
  --   end,
  -- },
  -- {
  --   "phha/zenburn.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = true,
  -- },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },

  { "tpope/vim-sleuth" },
  { "tpope/vim-vinegar" },
  { "tpope/vim-surround" },
  {
    "shortcuts/no-neck-pain.nvim",
    opts = {
      buffers = {
        right = {
          enabled = false,
        },
      },
    },
    keys = {
      {
        "<leader>np",
        ":NoNeckPain<CR>",
        desc = "[N]o neck [p]ain",
      },
    },
  },
  { "akinsho/git-conflict.nvim", version = "*", opts = { default_mappings = false } },
  { "ruifm/gitlinker.nvim", config = true },
  { "tpope/vim-fugitive", cmd = "Git" },

  -- {
  --   "tamago324/lir.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "kyazdani42/nvim-web-devicons",
  --   },
  --   config = function()
  --     local actions = require("lir.actions")
  --     local mark_actions = require("lir.mark.actions")
  --     local clipboard_actions = require("lir.clipboard.actions")
  --
  --     ---@diagnostic disable-next-line: missing-fields
  --     require("lir").setup({
  --       show_hidden_files = true,
  --       ignore = { ".DS_Store" },
  --       devicons = {
  --         enable = true,
  --         highlight_dirname = false,
  --       },
  --       mappings = {
  --         ["<CR>"] = actions.edit,
  --         ["<C-s>"] = actions.split,
  --         ["<C-v>"] = actions.vsplit,
  --         ["<C-t>"] = actions.tabedit,
  --
  --         ["h"] = actions.up,
  --         ["q"] = actions.quit,
  --
  --         ["d"] = actions.mkdir,
  --         ["n"] = actions.newfile,
  --         ["r"] = actions.rename,
  --         ["@"] = actions.cd,
  --         ["y"] = actions.yank_path,
  --         ["."] = actions.toggle_show_hidden,
  --         ["D"] = actions.delete,
  --
  --         ["C"] = clipboard_actions.copy,
  --         ["X"] = clipboard_actions.cut,
  --         ["P"] = clipboard_actions.paste,
  --       },
  --       ---@diagnostic disable-next-line: missing-fields
  --       float = {
  --         winblend = 0,
  --         curdir_window = {
  --           enable = false,
  --           highlight_dirname = false,
  --         },
  --       },
  --       hide_cursor = true,
  --     })
  --   end,
  -- },

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
      return opts
    end,
  },

  {
    "echasnovski/mini.files",
    opts = {
      windows = {
        preview = false,
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        typescript = function(bufnr)
          if require("conform").get_formatter_info("biome", bufnr).available then
            return { "biome", lsp_format = "never" }
          else
            return { "vtsls", "prettier" }
          end
        end,
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
    },
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
        function()
          require("telescope.builtin").git_files({ cwd = "$HOME/code/dotfiles" })
        end,
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

      -- Function to get the color of a highlight group
      local function get_color(hlgroup, attr)
        local color = vim.api.nvim_get_hl_by_name(hlgroup, true)[attr]
        if color then
          return string.format("#%06x", color)
        else
          return nil
        end
      end

      -- Get the colors from the current theme
      local black = get_color("Normal", "background")
      local white = get_color("Normal", "foreground")
      local gray = get_color("Comment", "foreground")

      local colors = {
        black = black,
        white = white,
        gray = gray,
      }

      local theme = {
        normal = {
          a = { bg = colors.black, fg = colors.white },
          b = { bg = colors.black, fg = colors.white },
          c = { bg = colors.black, fg = colors.white },
        },
      }

      local config = {
        options = {
          component_separators = "",
          section_separators = "",
          theme = theme,
        },
        sections = {
          lualine_a = {},
          lualine_b = {},
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
          lualine_y = {},
          lualine_z = {},
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
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
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
      }

      return config
    end,
  },

  { "nvim-pack/nvim-spectre", lazy = true, opts = { replace_engine = { sed = { cmd = "sed" } } } },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          filetypes_include = { "templ" },
        },
        -- htmx = {
        --   filetypes_include = { "templ" },
        -- },
        html = {
          filetypes_include = { "templ", "erb" },
        },
      },
    },
  },

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
        "templ",
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
