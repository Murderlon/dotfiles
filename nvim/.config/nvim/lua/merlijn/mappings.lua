local nnoremap = require("merlijn.keymap").nnoremap
local vnoremap = require("merlijn.keymap").vnoremap
local inoremap = require("merlijn.keymap").inoremap

nnoremap("<leader>w", "<CMD>w!<CR>")
nnoremap("<leader><cr>", "<CMD>noh<CR>") -- Disable highlight when <leader><cr> is pressed
nnoremap("<leader>q", "<CMD>bd<CR>") -- Close buffer
nnoremap("<leader>ba", "<CMD>bufdo bd<CR>") -- Close all buffers

-- Smart way to move between windows
nnoremap("<C-j>", "<C-W>j")
nnoremap("<C-k>", "<C-W>k")
nnoremap("<C-h>", "<C-W>h")
nnoremap("<C-l>", "<C-W>l")

-- Moving lines with Alt-j / Alt-k
-- https://stackoverflow.com/a/15399297/10798093
nnoremap("∆", ":m .+1<CR>==")
nnoremap("˚", ":m .-2<CR>==")

inoremap("∆", "<Esc>:m .+1<CR>==gi")
inoremap("˚", "<Esc>:m .-2<CR>==gi")

vnoremap("∆", ":m '>+1<CR>gv=gv")
vnoremap("˚", ":m '<-2<CR>gv=gv")

-- Move visual block
vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

-- Re-select visual block after indenting
vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- Keep search matches in the middle of the screen
nnoremap("n", "nzz")
nnoremap("N", "Nzz")
