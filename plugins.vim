call plug#begin('~/.config/nvim/plugged')
  " Settings
  Plug 'tpope/vim-sensible'

  " General
  Plug 'tpope/vim-vinegar'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-repeat'
  Plug 'tmsvg/pear-tree'
  Plug 'svermeulen/vim-easyclip'
  Plug 'christoomey/vim-system-copy'

  " Tmux <> Vim
  Plug 'tmux-plugins/vim-tmux-focus-events'
  Plug 'christoomey/vim-tmux-navigator'

  " Search
  Plug 'junegunn/fzf.vim'
   
  " Snippets
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'mlaursen/vim-react-snippets'

  " Git
  Plug 'tpope/vim-fugitive'
  Plug 'samoshkin/vim-mergetool'

  " Linting
  Plug 'w0rp/ale'

  " Completion
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

   "Syntax
  Plug 'pangloss/vim-javascript'
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'othree/html5.vim'
  Plug 'rust-lang/rust.vim'
  Plug 'MaxMEllon/vim-jsx-pretty'
  Plug 'tpope/vim-git'
  Plug 'elzr/vim-json'
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown'
  Plug 'vim-ruby/vim-ruby'
  Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

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
  Plug 'jacoborus/tender.vim'
  Plug 'cormacrelf/vim-colors-github'
  Plug 'fenetikm/falcon'
  Plug 'liuchengxu/space-vim-dark'
  Plug 'KeitaNakamura/neodark.vim'
  Plug 'junegunn/seoul256.vim'
  Plug 'arzg/vim-colors-xcode'
  Plug 'tpope/vim-vividchalk'
  Plug '~/.config/nvim/plugged/tpope'
  Plug 'jaredgorski/SpaceCamp'
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Prettier
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:prettier#autoformat = 0
let g:prettier#exec_cmd_async = 1
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue,*.yaml,*.html PrettierAsync
let g:prettier#config#semi = 'false'
let g:prettier#config#single_quote = 'true'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Easyclip
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:EasyClipAutoFormat=1
let g:EasyClipUseSubstituteDefaults=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => FZF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set rtp+=/usr/local/opt/fzf

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

command! -bang DotFiles call fzf#vim#files('~/dotfiles', <bang>0)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Syntax
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:vim_jsx_pretty_colorful_config = 1
let g:javascript_plugin_jsdoc = 1
au! BufNewFile,BufRead *.svelte set ft=html

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Markdown
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:vim_markdown_conceal = 0
let g:vim_markdown_fenced_languages = ['js=javascript']
let g:vim_markdown_folding_level = 3

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Merge tool
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:mergetool_layout = 'bmr'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ultisnips
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => LanguageClient
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:deoplete#enable_at_startup = 1

let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'typescript': ['javascript-typescript-stdio'],
    \ 'typescript.jsx': ['javascript-typescript-stdio'],
    \ }

let g:LanguageClient_rootMarkers = {
    \ 'javascript': ['jsconfig.json'],
    \ 'typescript': ['tsconfig.json'],
    \ }


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Pear tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1
