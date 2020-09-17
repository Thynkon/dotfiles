let mapleader = ","
let g:user_emmet_leader_key=','

" Go to normal mode when typing jk
imap jk <Esc>

" Make typing more comfortable
noremap é l
noremap l k
noremap k j
noremap j h

" Press space to toggle highlighting on/off, and show current value.
:noremap <Space> :set hlsearch! hlsearch?<CR>

" Omnicomplete Better Nav
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" By default timeoutlen is 1000 ms
set timeoutlen=500

nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
