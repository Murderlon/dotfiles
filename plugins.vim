call plug#begin('~/.config/nvim/plugged')
  " General
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-vinegar'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-repeat'
  Plug 'jiangmiao/auto-pairs'
  Plug 'svermeulen/vim-easyclip'
  Plug 'christoomey/vim-system-copy'
  Plug 'itchyny/lightline.vim'

  " Tmux <> Vim
  Plug 'tmux-plugins/vim-tmux-focus-events'
  Plug 'christoomey/vim-tmux-navigator'

  " Search
  Plug 'junegunn/fzf.vim'
  Plug 'romainl/vim-cool'
   
  " Snippets
  Plug 'honza/vim-snippets'
  Plug 'mlaursen/vim-react-snippets'

  " Git
  Plug 'tpope/vim-fugitive'
  Plug 'christoomey/vim-conflicted'

  " Linting
  Plug 'desmap/ale-sensible' | Plug 'w0rp/ale'

  " Completion
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

   "Syntax
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
  Plug 'Rigellute/shades-of-purple.vim'
  Plug 'gruvbox-material/vim', {'as': 'gruvbox-material'}
  Plug 'Rigellute/rigel'
  Plug 'wadackel/vim-dogrun'
  Plug 'jaredgorski/SpaceCamp'
  Plug 'relastle/bluewery.vim'
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
let g:vim_markdown_folding_disabled = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Conquer of Completion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
" Close the preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
