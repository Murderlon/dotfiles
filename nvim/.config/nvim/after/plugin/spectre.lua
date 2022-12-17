local spectre = require("spectre")
local nnoremap = require("merlijn.keymap").nnoremap

nnoremap("<leader>S", spectre.open)
nnoremap("<leader>sp", spectre.open_file_search)
