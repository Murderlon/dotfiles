return {
  {
    "dmtrKovalenko/fff.nvim",
    build = "cargo build --release",
    -- No need to lazy-load with lazy.nvim.
    -- This plugin initializes itself lazily.
    lazy = false,
    keys = {
      {
        "<leader><leader>",
        function()
          require("fff").find_files()
        end,
        desc = "FFFind files",
      },
      {
        "<leader>fd",
        function()
          require("fff").find_files_in_dir(vim.fn.expand("~/code/dotfiles"))
        end,
        desc = "FFFind files in dotfiles",
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader><leader>", false },
    },
  },
}
