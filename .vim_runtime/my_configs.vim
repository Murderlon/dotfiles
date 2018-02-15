" make .jsx extension not required for JSX syntax highlighting
let g:jsx_ext_required=0

" Remove mode indication (already provided by lightline)
set noshowmode

let g:lightline = {'colorscheme': 'onedark'}
" Always use the lightline theme declared above
let g:tmuxline_theme = 'lightline'

colorscheme onedark

" Disable folding 
set nofoldenable
