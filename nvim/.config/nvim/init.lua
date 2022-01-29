-- Disable netrw for lir.nvim
-- Needs to live here to prevent startup error
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require 'merlijn.plugins'
require 'merlijn.options'
require 'merlijn.mappings'
