call plug#begin()
  " Settings
  Plug 'tpope/vim-sensible'

  " Files
  " Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  Plug 'tpope/vim-vinegar'

  " Search
  "" If fzf has already been installed via Homebrew, use the existing fzf
  "" Otherwise, install fzf. The `--all` flag makes fzf accessible outside of vim
  if isdirectory("/usr/local/opt/fzf")
    Plug '/usr/local/opt/fzf'
  else
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  endif
  Plug 'junegunn/fzf.vim'
   
  " Completion
  Plug 'honza/vim-snippets'
  Plug 'mlaursen/vim-react-snippets'

  " Insertion
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-repeat'
  Plug 'svermeulen/vim-easyclip'

  " Movement
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'unblevable/quick-scope'

  " Utility
  Plug 'christoomey/vim-system-copy'
  Plug 'tmux-plugins/vim-tmux-focus-events'

  " Git
  Plug 'tpope/vim-fugitive'
  Plug 'samoshkin/vim-mergetool'

  " Linting
  Plug 'w0rp/ale'

  " Conquer Of Completion
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " Syntaxes and colorschemes
  source ./colors.vim
call plug#end()

" Conquer Of Completion
"" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
"" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
"" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Prettier
let g:prettier#autoformat = 0
let g:prettier#exec_cmd_async = 1
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue,*.yaml,*.html PrettierAsync
let g:prettier#config#semi = 'false'
let g:prettier#config#single_quote = 'true'
nmap <Leader>p <Plug>(Prettier)

" Easyclip
let g:EasyClipAutoFormat=1
let g:EasyClipUseSubstituteDefaults=1
nmap <leader>s <plug>(SubversiveSubstituteRange)
xmap <leader>s <plug>(SubversiveSubstituteRange)
nmap <leader>ss <plug>(SubversiveSubstituteWordRange)

" Quick scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" FZF
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0], 'options': ['--exact']}), <bang>0)

nnoremap <silent> <leader>t :Files<CR>
nnoremap <silent> <leader>T :Files!<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>s :GGrep<CR>

" Syntax
let g:vim_jsx_pretty_colorful_config = 1
let g:javascript_plugin_jsdoc = 1
au! BufNewFile,BufRead *.svelte set ft=html

" Markdown
let g:vim_markdown_conceal = 0
let g:vim_markdown_fenced_languages = ['js=javascript']
let g:vim_markdown_folding_level = 3

" Merge tool
let g:mergetool_layout = 'bmr'

