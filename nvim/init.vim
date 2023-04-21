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
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-signify'
Plug 'neovim/nvim-lspconfig'
Plug 'rhysd/vim-clang-format'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'ziglang/zig.vim'
call plug#end()

" ============= General =============
set clipboard^=unnamed,unnamedplus
set completeopt=menuone,noinsert,noselect
set shortmess+=c
set signcolumn=yes

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
lua require ('lsp_config')

" ============= Mappings =============
let mapleader=','

map <leader>c <Plug>CommentaryLine
map <leader>g :GitFiles<CR>
map <leader>f :Files<CR>
map <leader>n :Lexplore<CR>

augroup go
  autocmd FileType go nmap <silent> <Leader>x <Plug>(go-doc-vertical)
  autocmd FileType go nmap <silent> <leader>t <Plug>(go-test)
  autocmd FileType go nmap <silent> <leader>tf <Plug>(go-test-func)
  autocmd FileType go nmap <silent> <Leader>c <Plug>(go-coverage-toggle)
  autocmd FileType go nmap <silent> <leader>r <Plug>(go-referrers)
  autocmd FileType go nmap <silent> <leader>cl <Plug>(go-callers)
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

" ============= netrw =============
let g:netrw_altv=1
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_liststyle=3
let g:netrw_winsize=15

" ============= clang =============
let g:clang_format#auto_filetypes=['c', 'cpp']
let g:clang_format#auto_format=1
let g:clang_format#code_style='llvm'
let g:clang_format#detect_style_file=1
let g:clang_format#style_options={
            \ "IndentWidth": 2,
            \ "Standard" : "Latest",
            \ "SortIncludes" : "Never"}

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
let g:rust_clip_command='xclip -selection clipboard'

" ============= signify =============
let g:signify_vcs_list=['git']
let g:signify_sign_change='~'

" ============= vim-terraform =============
let g:terraform_align=1
let g:terraform_fmt_on_save=1

" ============= vim-airline =============
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_symbols.branch=''
