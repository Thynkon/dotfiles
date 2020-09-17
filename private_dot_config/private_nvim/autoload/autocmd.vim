" Highlight symbol under cursor on CursorHold
"autocmd CursorHold * silent call CocActionAsync('highlight')

"augroup mygroup
" autocmd!
"
" " Setup formatexpr specified filetype(s).
" autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
" " Update signature help on jump placeholder
" autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
"augroup end

"autocmd CursorHold * silent call CocActionAsync('highlight')

" Automatically opens nerdtree
"autocmd vimenter * NERDTree
"autocmd filetype python nnoremap <F4> :w <bar> exec '!python '.shellescape('%')<CR>
"autocmd filetype c nnoremap <F5> :w <bar> exec '!gcc '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
autocmd filetype c nnoremap <F5> :w <bar> :make <CR>
autocmd filetype cpp nnoremap <F5> :w <bar> :make <CR>
autocmd filetype rust nnoremap <F5> :w <bar> exec '!cargo run '.shellescape('%')<CR>
