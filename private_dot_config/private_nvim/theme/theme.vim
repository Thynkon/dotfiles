" Access colors present in 256 colorspace
let base16colorspace=256

" Theme and Styling 
set t_Co=256
set background=dark

if has('termguicolors')
  set termguicolors
endif

" Access colors present in 256 colorspace
let base16colorspace=256
" the configuration options should be placed before `colorscheme edge`
let g:edge_style = 'aura'
let g:edge_disable_italic_comment = 1
colorscheme edge

let g:spacegray_underline_search = 1
let g:spacegray_italicize_comments =1

" Vim-Airline Configuration
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='edge'
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1
