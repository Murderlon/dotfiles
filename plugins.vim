call plug#begin('~/.config/nvim/plugged')
  " Settings
  Plug 'tpope/vim-sensible'

  " General
  Plug 'tpope/vim-vinegar'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-repeat'
  Plug 'svermeulen/vim-easyclip'
  Plug 'unblevable/quick-scope'
  Plug 'christoomey/vim-system-copy'

  " Tmux <> Vim
  Plug 'tmux-plugins/vim-tmux-focus-events'
  Plug 'christoomey/vim-tmux-navigator'

  " Search
  Plug 'junegunn/fzf.vim'
   
  " Snippets
  Plug 'honza/vim-snippets'
  Plug 'mlaursen/vim-react-snippets'

  " Git
  Plug 'tpope/vim-fugitive'
  Plug 'samoshkin/vim-mergetool'

  " Linting
  Plug 'w0rp/ale'

  " Conquer Of Completion
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

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
" => Conquer Of Completion 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

let g:coc_snippet_next = '<tab>'

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

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
" => Quick scope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => FZF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set rtp+=/usr/local/opt/fzf

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0], 'options': ['--exact']}), <bang>0)


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

