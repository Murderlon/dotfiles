local nnoremap = require("merlijn.keymap").nnoremap

nnoremap("<leader>S", require("spectre").open)
nnoremap("<leader>sp", require("spectre").open_file_search)
