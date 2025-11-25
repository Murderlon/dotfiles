vim.opt.background = "dark"

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa",
    },
  },
  -- { "rose-pine/neovim", name = "rose-pine", opts = { styles = { italic = false } } },
  -- { "ellisonleao/gruvbox.nvim", opts = { bold = false } },
  { "projekt0n/github-nvim-theme" },
  { "aktersnurra/no-clown-fiesta.nvim" },
  { "rebelot/kanagawa.nvim" },
  -- { "ishan9299/nvim-solarized-lua" },
  -- { "ramojus/mellifluous.nvim" },
  -- { "EdenEast/nightfox.nvim" },
  -- { "bettervim/yugen.nvim" },
  { "catppuccin/nvim", name = "catppuccin", opts = { flavour = "macchiato" } },
  -- { "AlexvZyl/nordic.nvim", config = true },
  { "Mofiqul/vscode.nvim", config = true },
  -- { "loctvl842/monokai-pro.nvim", config = true },
  -- {
  --   "scottmckendry/cyberdream.nvim",
  --   lazy = false,
  -- },
}
