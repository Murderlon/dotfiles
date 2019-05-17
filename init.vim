call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'svermeulen/vim-easyclip'
Plug 'wincent/command-t', {
	\   'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make'
	\ }
Plug 'mileszs/ack.vim'
Plug 'w0rp/ale'
Plug 'sheerun/vim-polyglot'
Plug 'terryma/vim-multiple-cursors'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'christoomey/vim-tmux-navigator'
Plug 'styled-components/vim-styled-components'
Plug 'unblevable/quick-scope'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'terryma/vim-expand-region'

" Conquer Of Completion
function! InstallDeps(info)
    if a:info.status == 'installed' || a:info.force
        let extensions = [
          \'coc-html',
          \'coc-css',
          \'coc-vetur',
          \'coc-neosnippet',
          \'coc-tsserver',
          \'coc-json',
          \'coc-pairs',
          \]
        call coc#util#install()
        call coc#util#install_extension(extensions)
    endif
endfunction
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': function('InstallDeps')}

" Colorschemes
Plug 'icymind/NeoSolarized'
Plug 'haishanh/night-owl.vim'
Plug 'mhartington/oceanic-next'
Plug 'srcery-colors/srcery-vim'
Plug 'morhetz/gruvbox'
Plug 'kenwheeler/glow-in-the-dark-gucci-shark-bites-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'phanviet/vim-monokai-pro'
Plug 'joshdick/onedark.vim'
Plug 'tomasr/molokai'
Plug 'ayu-theme/ayu-vim'
Plug 'connorholyday/vim-snazzy'
Plug 'chriskempson/base16-vim'
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Relative line numbers
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

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = " "
let g:mapleader = " "

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file 
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" Python hosts
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" In CSS, hyphens are part of identifiers (keywords, properties, selectors...). 
" By adding it to the iskeyword list, vim will consider identifiers as a whole word.
au! FileType css,scss setl iskeyword+=-

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if exists('$TMUX')
  let &t_8f = "<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "<Esc>[48;2;%lu;%lu;%lum"
endif

syntax enable
set termguicolors
set background=dark
let g:onedark_terminal_italics=1
let g:nord_uniform_diff_background = 1
let g:nord_italic_comments = 1
let g:nord_italic = 1
let ayucolor="dark"
colorscheme OceanicNext

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store/*,*/target/*,*/node_modules/*,*/build/*,*/dist

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

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
set t_vb=
set tm=500

" Open new split panes to right and bottom,
" which feels more natural than Vim’s default
set splitbelow
set splitright

set noshowmode

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

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

""""""""""""""""""""""""""""""
" => Plugin settings
""""""""""""""""""""""""""""""
" Deoplete
let g:deoplete#enable_at_startup = 1

" Neosnippet
let g:neosnippet#enable_completed_snippet=1
let g:neosnippet#snippets_directory='~/.config/nvim/plugged/neosnippet-snippets/neosnippets'
let g:neosnippet#disable_runtime_snippets = {
\   '_' : 1,
\ }

imap <c-k> <Plug>(neosnippet_expand_or_jump)
smap <c-k> <Plug>(neosnippet_expand_or_jump)
xmap <c-k> <Plug>(neosnippet_expand_target)
vmap <c-k> <Plug>(neosnippet_expand_target)
inoremap <silent> <c-u> <c-r>=cm#sources#neosnippet#trigger_or_popup("\<Plug>(neosnippet_expand_or_jump)")<cr>
vmap <c-u> <Plug>(neosnippet_expand_target)

" Prettier
let g:prettier#autoformat = 0
let g:prettier#exec_cmd_async = 1
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
let g:prettier#config#semi = 'false'
let g:prettier#config#single_quote = 'true'

" Nerdtree
let NERDTreeShowHidden=1
let g:NERDTreeWinSize=35

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

map <leader>nn :NERDTreeToggle<cr>
map <leader>nf :NERDTreeFind<cr>

" Conquer of Completion
inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<TAB>"
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'

" Ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Easyclip
let g:EasyClipAutoFormat=1

" Quick scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Command T
 let g:CommandTCancelMap=['<ESC>', '<C-c>']
 nnoremap <silent> <leader>b :CommandTMRU<CR>

