set termguicolors
set background=light

let g:gruvbox_bold = '0'

let mapleader = " "
let g:mapleader = " "

colorscheme NeoSolarized

set number
set relativenumber

" Highlight the line of the cursor
set cursorline

" Disable line wrapping
set nowrap

" Start scrolling before the end
set scrolloff=8

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
set signcolumn=yes

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

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" In CSS, hyphens are part of identifiers (keywords, properties, selectors...).
" By adding it to the iskeyword list, vim will consider identifiers as a whole word.
au! FileType css,scss setl iskeyword+=-

" Trim whitespace on save in vim and lua files
autocmd BufWritePre *.vim :%s/\s\+$//e
autocmd BufWritePre *.lua :%s/\s\+$//e

inoremap jk <esc>
nnoremap a A

" Fast saving
nmap <leader>w :w!<cr>

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Close the current buffer
map <leader>q :bd<cr>

" Close all the buffers
map <leader>ba :bufdo bd<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Remap VIM 0 to first non-blank character
map 0 ^

" Moving lines with Alt-j / Alt-k
" https://stackoverflow.com/a/15399297/10798093
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==

inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi

vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Re-select visual block after indenting
vnoremap < <gv
vnoremap > >gv

" Keep search matches in the middle of the screen
nnoremap n nzz
nnoremap N Nzz

" Don't move to the next intance of a word when highlighting it
nnoremap * :let @/ = '\<'.expand('<cword>').'\>'\|set hlsearch<C-M>
