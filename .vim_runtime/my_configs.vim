" make .jsx extension not required for JSX syntax highlighting
let g:jsx_ext_required=0

" Remove mode indication (already provided by lightline)
set noshowmode
set relativenumber

let g:lightline = {'colorscheme': 'Dracula'}
" Always use the lightline theme declared above
let g:tmuxline_theme = 'lightline'
let g:tmuxline_powerline_separators = 0

colorscheme Dracula

" Show hidden files in NERDTree
let NERDTreeShowHidden=1
