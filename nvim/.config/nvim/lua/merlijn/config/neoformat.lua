vim.g.neoformat_enabled_javascript = { 'prettier', 'eslint_d' }
vim.g.neoformat_enabled_typescript = { 'prettier', 'eslint_d' }
vim.g.neoformat_enabled_markdown = { 'remark' }
vim.g.neoformat_run_all_formatters = 1

vim.api.nvim_set_keymap('n', '<leader>pp', '<CMD>Neoformat<CR>', { noremap = false })
