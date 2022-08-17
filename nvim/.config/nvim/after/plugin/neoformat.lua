local nnoremap = require("merlijn.keymap").nnoremap

vim.g.neoformat_enabled_javascript = { "prettierd", "eslint_d" }
vim.g.neoformat_enabled_typescript = { "prettierd", "eslint_d" }
vim.g.neoformat_enabled_markdown = { "remark" }

nnoremap("<leader>pp", "<CMD>Neoformat prettierd<CR>")
nnoremap("<leader>pe", "<CMD>Neoformat eslint_d<CR>")
nnoremap("<leader>pg", "<CMD>Neoformat<CR>")
