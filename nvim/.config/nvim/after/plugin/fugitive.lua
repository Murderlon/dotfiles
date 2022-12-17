local nnoremap = require("merlijn.keymap").nnoremap

nnoremap("<leader>gg", vim.cmd.Git)
nnoremap("<leader>gc", ":Git commit<CR>")
nnoremap("<leader>gp", ":Git push<CR>")
nnoremap("<leader>gb", ":Git blame<CR>")
