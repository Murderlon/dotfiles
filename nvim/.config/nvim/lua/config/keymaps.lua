-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local nnoremap = require("merlijn.keymap").nnoremap
local vnoremap = require("merlijn.keymap").vnoremap
local xnoremap = require("merlijn.keymap").xnoremap
local inoremap = require("merlijn.keymap").inoremap

-- Save files
nnoremap("<leader>w", ":w!<CR>")
nnoremap("<leader>wx", "<cmd>!chmod +x %<CR>", { silent = true }) -- as executable

nnoremap("<leader>cp", ":let @+ = expand('%')<CR>", { silent = true, desc = "Copy file path" })

-- Moving lines with Alt-j / Alt-k
-- https://stackoverflow.com/a/15399297/10798093
nnoremap("∆", ":m .+1<CR>==")
nnoremap("˚", ":m .-2<CR>==")
inoremap("∆", "<Esc>:m .+1<CR>==gi")
inoremap("˚", "<Esc>:m .-2<CR>==gi")
vnoremap("∆", ":m '>+1<CR>gv=gv")
vnoremap("˚", ":m '<-2<CR>gv=gv")

-- Re-select visual block after indenting
vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- Paste over a selection and keep previous paste
xnoremap("<leader>p", [["_dP]])

-- Save yank to os clipboard
nnoremap("<leader>y", [["+y]])
vnoremap("<leader>y", [["+y]])
nnoremap("<leader>Y", [["+Y]])

-- Open tmux sessionizer then close the window when done
nnoremap("<C-p>", ":silent !tmux neww tmux-sessionizer.sh<CR>")

-- Quickfix list navigation
nnoremap("<C-W>k", "<cmd>cnext<CR>zz")
nnoremap("<C-W>j", "<cmd>cprev<CR>zz")

-- Search and replace word under cursor in the entire file
nnoremap("<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
