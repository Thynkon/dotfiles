syntax on
set nowrap
set encoding=utf8

" set cursor to terminal like
set guicursor=

" Incrementally highlights ALL pattern matches
set incsearch
set autoindent

" Show linenumbers
set number
set relativenumber
set ruler

" lines longer than 79 columns will be broken
set textwidth=79
" align the new line indent with the previous line
set autoindent

" Copy to system's clipboard using yy
set clipboard=unnamed

" Always display the status line
set laststatus=2

" Enable Elite mode, No ARRRROWWS!!!!
let g:elite_mode = 1

" Enable highlighting of the current line
set cursorline

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Disable arrow movement, resize splits instead.
if get(g:, 'elite_mode')
    nnoremap <Up>    :resize +2<CR>
    nnoremap <Down>  :resize -2<CR>
    nnoremap <Left>  :vertical resize +2<CR>
    nnoremap <Right> :vertical resize -2<CR>
endif
