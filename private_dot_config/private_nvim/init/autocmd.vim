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
