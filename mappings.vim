" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = " "
let g:mapleader = " "

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file 
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

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
map <leader>q :bd<cr>

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
nnoremap ‚àÜ :m .+1<CR>==
nnoremap Àö :m .-2<CR>==
inoremap ‚àÜ <Esc>:m .+1<CR>==gi
inoremap Àö <Esc>:m .-2<CR>==gi

vnoremap ‚àÜ :m '>+1<CR>gv=gv
vnoremap Àö :m '<-2<CR>gv=gv

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
" => Conquer Of Completion 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for rename current word
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

"" Snippet completion
let g:coc_snippet_next = '<tab>'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Prettier
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap <Leader>p <Plug>(Prettier)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Easyclip
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap <leader>s <plug>(SubversiveSubstituteRange)
xmap <leader>s <plug>(SubversiveSubstituteRange)
nmap <leader>ss <plug>(SubversiveSubstituteWordRange)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => FZF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <silent> <leader>t :Files<CR>
nnoremap <silent> <leader>T :Files!<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>s :GGrep<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Prettier
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
