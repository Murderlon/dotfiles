-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.clipboard = "" -- Do not sync clipboard with system clipboard

vim.opt.list = true -- Do not show invisible characters

vim.g.lazyvim_prettier_needs_config = true

vim.g.netrw_fastbrowse = 0

-- Don't need swap files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- Hide these files in netrw
vim.opt.wildignore:append({ ".DS_Store" })

vim.opt.showmode = false -- Show when we enter a recording

vim.opt.conceallevel = 0

vim.opt.list = false

vim.g.root_spec = { "cwd" }
vim.g.snacks_animate = false
-- vim.g.lazyvim_picker = "telescope"
