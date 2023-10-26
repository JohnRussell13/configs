call plug#begin()

Plug 'tpope/vim-sensible'		" Simple features
Plug 'ThePrimeagen/vim-be-good'		" Game for learning nvim
Plug 'cohama/lexima.vim'		" Auto-close symbols
" Plug 'morhetz/gruvbox'			" Theme
Plug 'joshdick/onedark.vim'		" Theme
Plug 'nvim-lua/completion-nvim'		" Auto-complete

call plug#end()

set relativenumber	" Line numbering

" colorscheme gruvbox	" For gruvbox
colorscheme onedark

" START for completion-nvim
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c
" END for completion-nvim

