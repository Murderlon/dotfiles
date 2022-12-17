local nnoremap = require("merlijn.keymap").nnoremap

require("trouble").setup({})

nnoremap("<leader>xx", ":TroubleToggle<cr>")
nnoremap("<leader>xw", ":TroubleToggle workspace_diagnostics<cr>")
nnoremap("<leader>xd", ":TroubleToggle document_diagnostics<cr>")
