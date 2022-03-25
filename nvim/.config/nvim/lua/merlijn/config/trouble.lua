require('trouble').setup{}

local options = { silent = true, noremap = true }

vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", options)
vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", options)
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", options)
