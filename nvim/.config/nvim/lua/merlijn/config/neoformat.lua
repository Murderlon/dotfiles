vim.g.neoformat_enabled_javascript = { 'prettierd', 'eslint_d' }
vim.g.neoformat_enabled_typescript = { 'prettierd', 'eslint_d' }
vim.g.neoformat_enabled_markdown = { 'remark' }

vim.api.nvim_set_keymap('n', '<leader>pp', '<CMD>Neoformat prettierd<CR>', { noremap = false })
vim.api.nvim_set_keymap('n', '<leader>pe', '<CMD>Neoformat eslint_d<CR>', { noremap = false })
vim.api.nvim_set_keymap('n', '<leader>pg', '<CMD>Neoformat<CR>', { noremap = false })
