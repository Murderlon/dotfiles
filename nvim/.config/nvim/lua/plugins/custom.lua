return {
  -- Disable plugins
  { "echasnovski/mini.indentscope", enabled = false },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  { "folke/noice.nvim", enabled = false },
  { "akinsho/bufferline.nvim", enabled = false },
  { "rcarriga/nvim-notify", enabled = false },
  -- Colorschemes
  {
    "uloco/bluloco.nvim",
    dependencies = { "rktjmp/lush.nvim" },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "bluloco",
    },
  },

  { "tpope/vim-vinegar" },
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
    dependencies = { "onsails/lspkind.nvim" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local lspkind = require("lspkind")
      local cmp = require("cmp")
      local confirm = opts.mapping["<CR>"]
      local confirm_copilot = cmp.mapping.confirm({
        select = true,
        behavior = cmp.ConfirmBehavior.Replace,
      })

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<C-k>"] = function(...)
          local entry = cmp.get_selected_entry()
          if entry and entry.source.name == "copilot" then
            return confirm_copilot(...)
          end
          return confirm(...)
        end,
      })
      opts.formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text",
          menu = {
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[LuaSnip]",
            nvim_lua = "[Lua]",
            copilot = "[Copilot]",
          },
          maxwidth = 50,
        }),
      }
      vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
      lspkind.init({ symbol_map = { Copilot = "" } })
    end,
  },

  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>fd",
        function()
          require("telescope.builtin").git_files({ cwd = "$HOME/Dotfiles", prompt_title = "Dotfiles" })
        end,
        desc = "[F]ind [D]otfiles",
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.sections.lualine_a = {} -- Remove vim mode section
      opts.sections.lualine_z = {} -- Remove time section
    end,
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
