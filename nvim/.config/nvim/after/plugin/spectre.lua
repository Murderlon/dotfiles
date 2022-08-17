local nnoremap = require("merlijn.keymap").nnoremap

nnoremap("<leader>S", '<CMD>lua require("spectre").open()<CR>')
nnoremap("<leader>sp", '<CMD>lua require("spectre").open_file_search()<CR>')
