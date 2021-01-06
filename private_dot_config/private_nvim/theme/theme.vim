" Theme and Styling 
set t_Co=256
set background=dark

if has('termguicolors')
  set termguicolors
endif

" Access colors present in 256 colorspace
let base16colorspace=256
colorscheme onedark

" Show colors in current buffer
lua << EOF
require 'colorizer'.setup ({
  '*';
  css = { rgb_fn = true; }; -- Enable parsing rgb(...) functions in css.
  html = { names = false; } -- Disable parsing "names" like Blue or Gray
},{RRGGBBAA = true})
EOF

let g:spacegray_underline_search = 1
let g:spacegray_italicize_comments =1

" Vim-Airline Configuration
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='onedark'
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1
