set termguicolors
set background=dark
colorscheme NeoSolarized

set number
set relativenumber

" Highlight the line of the cursor
set cursorline

" Disable line wrapping
set nowrap

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

set ai "Auto indent
set si "Smart indent

" Refresh file on change
set autoread

" Current working directory
set path=$PWD/**

" Ignore these folders and files
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store/*,*/target/*,*/node_modules/*,*/build/*,*/built/*,*/dist/*,*/yarn.lock/*,*/package-lock.json/*

" Better display for messages
set cmdheight=2

set updatetime=300

" always show signcolumns
set signcolumn=no

" A buffer becomes hidden when it is abandoned
set hid

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set visualbell t_vb=
set tm=500

" Open new split panes to right and bottom,
" which feels more natural than Vim’s default
set splitbelow
set splitright

" Disable swap files
set noswapfile

" Old regexp engine will incur performance issues for yats and old engine is usually turned on by other plugins
set re=0

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
