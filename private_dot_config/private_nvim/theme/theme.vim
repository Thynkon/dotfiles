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

lua << EOF
local lualine = require('lualine')

lualine.status()
lualine.theme = "onedark"
EOF
