call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'fatih/molokai'
Plug 'fatih/vim-go'
Plug 'fatih/vim-hclfmt'
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'davidhalter/jedi-vim'
Plug 'zchee/deoplete-jedi'

call plug#end()

set number
set clipboard=unnamed

let g:go_fmt_command = "goimports"
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:deoplete#enable_at_startup = 1
let g:rehash256 = 1
let g:molokai_original = 1
let g:airline#extensions#branch#enabled = 1
let g:jedi#force_py_version=3

colorscheme molokai
