" ============= vim-plug =============
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'fatih/vim-go'
Plug 'fatih/vim-hclfmt'
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'davidhalter/jedi-vim'
Plug 'zchee/deoplete-jedi'
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
call plug#end()

" ============= clipboard =============
set clipboard^=unnamed,unnamedplus

" ============= UI =============
colorscheme dark

set number
set cursorline
set showmatch
set matchtime=2
set mouse=a
set tabstop=4
set softtabstop=4
set shiftwidth=4

" ============= Search =============
set ignorecase
set smartcase

" ============= Mappings =============
let mapleader=","

map <leader>n :NERDTreeToggle<CR>

augroup go
  autocmd FileType go nmap <silent> <Leader>x <Plug>(go-doc-vertical)
  autocmd FileType go nmap <silent> <leader>t <Plug>(go-test)
  autocmd FileType go nmap <silent> <Leader>c <Plug>(go-coverage-toggle)
  autocmd FileType go nmap <silent> <leader>r <Plug>(go-run)
  autocmd FileType go nmap <silent> <leader>i <Plug>(go-install)
  autocmd FileType go nmap <leader>d <Plug>(go-def)
augroup END

" ============= NERDTree =============
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.pyc$', '.DS_STORE']

" ============= vim-go =============
let g:go_fmt_command="goimports"
let g:go_auto_type_info=1
let g:go_highlight_fields=1
let g:go_highlight_functions=1
let g:go_highlight_methods=1
let g:go_highlight_structs=1
let g:go_highlight_types=1
let g:go_highlight_operators=1
let g:go_highlight_extra_types=1
let g:go_highlight_build_constraints=1
let g:go_highlight_generate_tags=1
let g:go_metalinter_autosave=1
let g:go_metalinter_autosave_enabled=['vet', 'golint']

" ============= deoplete =============
let g:deoplete#enable_at_startup=1

" ============= airline =============
let g:airline#extensions#branch#enabled=1

" ============= jedi =============
let g:jedi#force_py_version=3

" ============= rust =============
let g:rustfmt_autosave=1
