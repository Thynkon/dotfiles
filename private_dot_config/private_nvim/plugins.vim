call plug#begin(stdpath('data') . '/plugged')
" Make sure you use single quotes

" Utility
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar' " side bar
Plug 'wesQ3/vim-windowswap'
"Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-sleuth'
Plug 'easymotion/vim-easymotion'
Plug 'Yggdroot/indentLine'
Plug 'liuchengxu/vim-which-key'

" Generic Programming Support 
" Plugin 'jakedouglas/exuberant-ctags'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs' " Vim plugin, insert or delete brackets, parens, quotes in pair
Plug 'janko-m/vim-test'
Plug 'alvan/vim-closetag'

" Markdown / Writting
Plug 'tpope/vim-markdown'
Plug 'dpelle/vim-LanguageTool'
Plug 'lervag/vimtex'

" Git Support
Plug 'gregsexton/gitv'
Plug 'tpope/vim-fugitive'

" Completion framework
" Use release branch (Recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'

" Python
" pep8 indentation
Plug 'Vimjas/vim-python-pep8-indent'

" Theme / Interface
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'joshdick/onedark.vim'

" Initialize plugin system
call plug#end()
