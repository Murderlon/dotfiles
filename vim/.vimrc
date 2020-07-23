if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
  " General
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-vinegar'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-repeat'
  Plug 'svermeulen/vim-easyclip'
  Plug 'christoomey/vim-system-copy'
  " Plug 'mkitt/tabline.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " Search
  " The bang version will try to download the prebuilt binary if cargo does not exist.
  Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
   
  " Snippets
  Plug 'honza/vim-snippets'
  Plug 'mlaursen/vim-react-snippets'

  " Git
  Plug 'tpope/vim-fugitive'

  " Linting
  " Plug 'desmap/ale-sensible' | Plug 'w0rp/ale'

  " Completion
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " Syntax
  Plug 'pangloss/vim-javascript'
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'othree/html5.vim'
  Plug 'rust-lang/rust.vim'
  Plug 'MaxMEllon/vim-jsx-pretty'
  Plug 'tpope/vim-git'
  Plug 'elzr/vim-json'
  Plug 'plasticboy/vim-markdown'
  Plug 'vim-ruby/vim-ruby'
  Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
  Plug 'Glench/Vim-Jinja2-Syntax'

  " Colorschemes
  Plug 'overcache/NeoSolarized'
  Plug 'mhartington/oceanic-next'
  Plug 'junegunn/seoul256.vim'
call plug#end()

set termguicolors
set background=dark
colorscheme seoul256 
let g:github_colors_soft = 1
let g:airline_theme='seoul256'
" remove the filetype part
let g:airline_section_y=''
" remove separators for empty sections
let g:airline_skip_empty_sections = 1

" MacVim
set guifont=Iosevka\:h18
set macligatures
set guioptions=

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader = " "
let g:mapleader = " "

" Fast saving
nmap <leader>w :w!<cr>

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Close the current buffer
map <leader>q :bd<cr>

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

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

" Don't move to the next intance of a word when highlighting it
nnoremap * :let @/ = '\<'.expand('<cword>').'\>'\|set hlsearch<C-M>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Syntax
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

au! BufNewFile,BufRead *.svelte set ft=html
au! BufNewFile,BufRead *.mdx set ft=markdown
" In CSS, hyphens are part of identifiers (keywords, properties, selectors...). 
" By adding it to the iskeyword list, vim will consider identifiers as a whole word.
au! FileType css,scss setl iskeyword+=-

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Clap
let g:clap_theme = 'solarized_light'
let g:clap_layout = { 'relative': 'editor' }

nnoremap <silent> <leader>t :Clap files<CR>
nnoremap <silent> <leader>s :Clap grep<CR>
nnoremap <silent> <leader>b :Clap buffers<CR>

" Prettier
let g:prettier#autoformat = 0
let g:prettier#exec_cmd_async = 1

nmap <Leader>p <Plug>(Prettier)

" Syntax
let g:vim_jsx_pretty_colorful_config = 1
let g:javascript_plugin_jsdoc = 1

let g:vim_markdown_conceal = 0
let g:vim_markdown_fenced_languages = ['js=javascript', 'ts=typescript']
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Conquer of Completion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
