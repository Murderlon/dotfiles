require('trouble').setup{}

local options = { silent = true, noremap = true }

vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>", options)
vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", options)
