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
autocmd filetype tex nnoremap <F5> :w <bar> exec '!pdflatex main.tex '.shellescape('%')<CR>

autocmd filetype c nnoremap <F5> :w <bar> :make <CR>
autocmd filetype cpp nnoremap <F5> :w <bar> :make <CR>

autocmd filetype rust nnoremap <F5> :w <bar> exec '!cargo run '.shellescape('%')<CR>
