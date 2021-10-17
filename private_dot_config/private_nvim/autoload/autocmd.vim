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

" Show diagnostic popup on cursor hover
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" Enable type inlay hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment" }

" Enable code action's shortcuts (automatically import missing libraries, fix
" code, etc...)
autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()

autocmd filetype tex nnoremap <F5> :w <bar> exec '!make'<CR>

autocmd filetype c nnoremap <F5> :w <bar> :make <CR>
autocmd filetype cpp nnoremap <F5> :w <bar> :make <CR>

autocmd filetype rust nnoremap <F5> :w <bar> exec '!cargo run '.shellescape('%')<CR>
autocmd filetype rust nnoremap <F6> :w <bar> exec '!cargo test'<CR>

autocmd FileType html,css EmmetInstall
