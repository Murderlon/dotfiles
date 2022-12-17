local nnoremap = require("merlijn.keymap").nnoremap
local vnoremap = require("merlijn.keymap").vnoremap
local xnoremap = require("merlijn.keymap").xnoremap
local inoremap = require("merlijn.keymap").inoremap

-- Save files
nnoremap("<leader>w", ":w!<CR>")
nnoremap("<leader>wx", "<cmd>!chmod +x %<CR>", { silent = true }) -- as executable

-- Disable highlight when <leader><cr> is pressed
nnoremap("<leader><cr>", ":noh<CR>")

-- Move between windows quicker
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

-- Re-select visual block after indenting
vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- Keep cursor in the right place
nnoremap("J", "mzJ`z")
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")

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
