vim.g.mapleader = " "

vim.cmd.colorscheme "rose-pine"
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.guicursor = ""

vim.g.python_host_prog = "/usr/bin/python"
vim.g.python3_host_prog = "/usr/local/bin/python3"

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 99

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wrap = false

vim.opt.scrolloff = 8

vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

vim.opt.smartindent = true

vim.opt.cmdheight = 1

vim.opt.updatetime = 50

vim.opt.signcolumn = "yes"

vim.opt.hidden = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.showmatch = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.backup = false
vim.opt.writebackup = false

vim.opt.wildignore = ".DS_Store"

vim.opt.belloff = "all"

vim.opt.shortmess:append("c") -- Don't pass messages to ins-completion-menu
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.formatoptions = vim.opt.formatoptions -- see :h fo-table
	- "a" -- Auto formatting is BAD.
	- "t" -- Don't auto format my code. I got linters for that.
	+ "c" -- Comments respect textwidth
	+ "q" -- Allow formatting comments w/ gq
	- "o" -- O and o, don't continue comments
	+ "n" -- Indent past the formatlistpat, not underneath it.
	+ "j" -- Auto-remove comments if possible.
	- "2" -- Use the indent of the second line of a paragraph
