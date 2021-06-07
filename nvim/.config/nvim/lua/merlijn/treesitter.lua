require 'nvim-treesitter.install'.compilers = { "gcc", "clang" }

require'nvim-treesitter.configs'.setup {
  ensure_installed = { 'bash', 'cpp', 'comment', 'css', 'graphql', 'html', 'javascript', 'jsdoc', 'json', 'lua', 'python', 'regex', 'tsx', 'vue', 'typescript' },
  highlight = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

parser_config.ejs = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-embedded-template",
    files = {"src/parser.c"}
  },
  filetype = "ejs"
}
