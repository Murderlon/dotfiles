return {
  {
    "dmtrKovalenko/fff.nvim",
    build = function()
      -- this will download prebuild binary or try to use existing rustup toolchain to build from source
      -- (if you are using lazy you can use gb for rebuilding a plugin if needed)
      require("fff.download").download_or_build_binary()
    end,
    -- No need to lazy-load with lazy.nvim.
    -- This plugin initializes itself lazily.
    lazy = false,
    opts = {
      prompt = "> ",
    },
    keys = {
      {
        "<leader><leader>",
        function()
          require("fff").find_files_in_dir(vim.fn.getcwd())
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
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader><leader>", false },
    },
  },
}
