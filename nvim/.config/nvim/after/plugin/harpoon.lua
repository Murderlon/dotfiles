local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local nnoremap = require("merlijn.keymap").nnoremap

local function nav_file (n)
  return function ()
    ui.nav_file(n)
  end
end

nnoremap("<leader>ha", mark.add_file)
nnoremap("<leader>hq", ui.toggle_quick_menu)

nnoremap("<leader>h1", nav_file(1))
nnoremap("<leader>h2", nav_file(2))
nnoremap("<leader>h3", nav_file(3))
nnoremap("<leader>h4", nav_file(4))
nnoremap("<leader>h5", nav_file(5))
nnoremap("<leader>h6", nav_file(6))
nnoremap("<leader>h7", nav_file(7))
nnoremap("<leader>h8", nav_file(8))
