vim.opt.background = "light"

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
  { "rose-pine/neovim", name = "rose-pine", opts = { styles = { italic = false } } },
  { "ellisonleao/gruvbox.nvim", opts = { bold = false } },
  -- { "projekt0n/github-nvim-theme" },
  -- { "aktersnurra/no-clown-fiesta.nvim" },
  -- { "ishan9299/nvim-solarized-lua" },
  -- { "ramojus/mellifluous.nvim" },
  -- { "EdenEast/nightfox.nvim" },
  -- { "bettervim/yugen.nvim" },
  -- { "catppuccin/nvim", name = "catppuccin", opts = { flavour = "macchiato" } },
  -- {
  --   "AlexvZyl/nordic.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("nordic").load()
  --   end,
  -- },
  -- {
  --   "scottmckendry/cyberdream.nvim",
  --   lazy = false,
  -- },
}
