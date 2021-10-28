require 'nvim-treesitter.install'.compilers = { "gcc", "clang" }

require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    'bash',
    'cpp',
    'comment',
    'css',
    'scss',
    'graphql',
    'html',
    'javascript',
    'jsdoc',
    'json',
    'lua',
    'python',
    'regex',
    'tsx',
    'vue',
    'typescript'
  },
  highlight = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
  indent = { enable = true }
}
