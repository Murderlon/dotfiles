require 'nvim-treesitter.install'.compilers = { "gcc", "clang" }

require'nvim-treesitter.configs'.setup {
  ensure_installed = 'maintained',
  highlight = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
  indent = { enable = true }
}
