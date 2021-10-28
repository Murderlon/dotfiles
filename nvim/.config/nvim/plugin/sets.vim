set termguicolors
set background=dark
set number
set relativenumber
set cursorline
set nowrap
set scrolloff=8
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
set smartindent
set autoread
set path=$PWD/**
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store/*,*/target/*,*/node_modules/*,*/build/*,*/built/*,*/dist/*,*/yarn.lock/*,*/package-lock.json/*
set cmdheight=2
set updatetime=50
set signcolumn=yes
set hidden
set ignorecase
set smartcase
set hlsearch
set incsearch
set showmatch
set splitbelow
set splitright
set noswapfile
set nobackup
set nowritebackup
set shortmess+=c " Don't pass messages to ins-completion-menu

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" In CSS, hyphens are part of identifiers (keywords, properties, selectors...).
" By adding it to the iskeyword list, vim will consider identifiers as a whole word.
au! FileType css,scss setl iskeyword+=-
