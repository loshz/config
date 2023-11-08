" ============= vim-plug =============
call plug#begin('~/.vim/plugged')
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'hashivim/vim-terraform'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-signify'
Plug 'neovim/nvim-lspconfig'
Plug 'ntpeters/vim-better-whitespace'
Plug 'rhysd/vim-clang-format'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'ziglang/zig.vim'
call plug#end()

" ============= General =============
set clipboard=unnamedplus
set completeopt=menuone,noinsert,noselect
set shortmess+=c
set signcolumn=yes

" ============= statusline =============
set laststatus=2
set statusline=
set statusline+=%F
set statusline+=\ 
set statusline+=%m
set statusline+=%h
set statusline+=%r
set statusline+=%=
set statusline+=%{substitute(substitute(FugitiveStatusline(),'\[Git\(','',''),'\)\]','','')}
set statusline+=\ 
set statusline+=\|
set statusline+=\ 
set statusline+=%l
set statusline+=:
set statusline+=%L
set statusline+=\ 
set statusline+=%{strlen(&fenc)?&fenc:'none'}
set statusline+=%y

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

" ============= LSP =============
lua require ('lsp')

" ============= Mappings =============
let mapleader=','

map <leader>c :Commentary<CR>
map <leader>g :GitFiles<CR>
map <leader>f :Files<CR>

augroup go
  autocmd FileType go nmap <silent> <Leader>x <Plug>(go-doc-vertical)
  autocmd FileType go nmap <silent> <leader>t <Plug>(go-test)
  autocmd FileType go nmap <silent> <leader>tf <Plug>(go-test-func)
  autocmd FileType go nmap <silent> <Leader>tc <Plug>(go-coverage-toggle)
  autocmd FileType go nmap <silent> <leader>r <Plug>(go-referrers)
  autocmd FileType go nmap <silent> <leader>c <Plug>(go-callers)
  autocmd FileType go nmap <leader>d <Plug>(go-def)
  autocmd FileType go imap <buffer> . .<C-x><C-o>
  autocmd FileType go let b:go_fmt_options = {'goimports': '-local ' . trim(system('go list -m'))}
augroup END

augroup rust
  autocmd FileType rust nmap <silent> <leader>t :belowright 16RustTest<CR>
  autocmd FileType rust nmap <silent> <leader>tt :belowright 16RustTest!<CR>
augroup END

augroup proto
  autocmd BufWritePost *.proto silent !buf format -w
augroup END

" ============= clang =============
let g:clang_format#auto_filetypes=['c', 'cpp']
let g:clang_format#auto_format=1
let g:clang_format#detect_style_file=1

" ============= go =============
let g:go_fmt_command='goimports'
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
let g:go_jump_to_error=0
let g:go_template_autocreate=0

" ============= rust =============
let g:rustfmt_autosave=1

" ============= signify =============
let g:signify_vcs_list=['git']
let g:signify_sign_change='~'

" ============= vim-terraform =============
let g:terraform_align=1
let g:terraform_fmt_on_save=1
