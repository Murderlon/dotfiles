local opt = vim.opt

vim.g.python_host_prog = '/usr/bin/python'
vim.g.python3_host_prog = '/usr/local/bin/python3'

opt.termguicolors = true
opt.background = 'dark'
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.wrap = false
opt.scrolloff = 8
opt.expandtab = true
opt.smarttab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true
opt.cmdheight = 2
opt.updatetime = 50
opt.signcolumn = 'yes'
opt.hidden = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.showmatch = true
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.belloff = 'all' -- Just turn the dang bell off
opt.shortmess:append('c') -- Don't pass messages to ins-completion-menu
opt.wildignore = '.DS_Store'
opt.formatoptions = opt.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  + "c" -- In general, I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- I'm not in gradeschool anymore
