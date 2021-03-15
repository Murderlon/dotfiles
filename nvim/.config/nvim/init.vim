"   __  __ ______ _____  _      _____     _ _   _ _
" |  \/  |  ____|  __ \| |    |_   _|   | | \ | ( )
" | \  / | |__  | |__) | |      | |     | |  \| |/ ___
" | |\/| |  __| |  _  /| |      | | _   | | . ` | / __|
" | |  | | |____| | \ \| |____ _| || |__| | |\  | \__ \
" |_|  |_|______|_|__\_\______|_____\____/|_| \_| |___/
" | \ | |  ____/ __ \ \    / /_   _|  \/  |
" |  \| | |__ | |  | \ \  / /  | | | \  / |
" | . ` |  __|| |  | |\ \/ /   | | | |\/| |
" | |\  | |___| |__| | \  /   _| |_| |  | |
" |_|_\_|______\____/ __\/__ |_____|_|__|_|
"  / ____/ __ \| \ | |  ____|_   _/ ____|
" | |   | |  | |  \| | |__    | || |  __
" | |   | |  | | . ` |  __|   | || | |_ |
" | |___| |__| | |\  | |     _| || |__| |
"  \_____\____/|_| \_|_|    |_____\_____|
"
" How this config works:
"
" - Load plugins with plug
"
" - The lua require loads the lua init.lua file from lua/merlijn/init.lua.
"   We use the extra folder ("merlijn") to namespace the files to avoid conflicts.
"
" - All the *.vim files in /plugin are loaded. These set basic vim settings and add mappings.
"
" - The after/plugin folder has *.vim config file for every plugin that needs settings.
"   This is loaded after everything else has loaded.
"
" - The ftdetect folder is used to set a certain syntax for a certain file extension.
"
" More info on vim directories:
" https://learnvimscriptthehardway.stevelosh.com/chapters/42.html

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
  " General
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-vinegar'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-repeat'
  Plug 'svermeulen/vim-easyclip'
  Plug 'christoomey/vim-system-copy'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'kyazdani42/nvim-web-devicons'

  " Search
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzy-native.nvim'

  " Snippets
  Plug 'honza/vim-snippets'
  Plug 'mlaursen/vim-react-snippets'

  " Git
  Plug 'tpope/vim-fugitive'

  " Language server
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " Syntax
  Plug 'sheerun/vim-polyglot'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  " Colorschemes
  Plug 'overcache/NeoSolarized'
  Plug 'mhartington/oceanic-next'
  Plug 'junegunn/seoul256.vim'
  Plug 'bignimbus/pop-punk.vim'
  Plug 'kyazdani42/blue-moon'
  Plug 'wadackel/vim-dogrun'
call plug#end()

lua require("merlijn")

let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'
