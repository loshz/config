" ============= vim-plug =============
call plug#begin('~/.vim/plugged')
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'hashivim/vim-terraform'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'mhinz/vim-signify'
Plug 'neovim/nvim-lspconfig'
Plug 'rhysd/vim-clang-format'
Plug 'rhysd/vim-go-impl'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'SirVer/ultisnips'
Plug 'vim-airline/vim-airline'
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
lua << EOF
local nvim_lsp = require'lspconfig'

nvim_lsp.rust_analyzer.setup({
    settings = {
		-- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "crate",
				importGroup = true,
            },
		    autoimport = {
                enable = true
			},
            cargo = {
                loadOutDirsFromCheck = true
            },
            checkOnSave = {
                command = "clippy"
            },
        }
    }
})
EOF

lua <<EOF
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  sources = {
    { name = 'nvim_lsp' },
  },
})
EOF

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

augroup rust
  autocmd FileType rust nmap <silent> <leader>t :belowright 16RustTest<CR>
  autocmd FileType rust nmap <silent> <leader>tt :belowright 16RustTest!<CR>
augroup END

augroup comment
  autocmd FileType c,cpp,go,rust nmap <silent> <leader>cc I//<esc>
  autocmd FileType python,yaml  nmap <silent> <leader>cc I#<esc>
augroup END

" ============= NERDTree =============
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.pyc$', '.DS_STORE']

" ============= clang =============
let g:clang_format#auto_filetypes=["c", "cpp", "proto"]
let g:clang_format#auto_format=0
let g:clang_format#code_style="llvm"
let g:clang_format#detect_style_file=1
let g:clang_format#style_options = {
            \ "IndentWidth": 2,
            \ "Standard" : "Latest",
            \ "SortIncludes" : "Never"}

" ============= go =============
let g:go_fmt_command="goimports"
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

" ============= deoplete =============
let g:deoplete#enable_at_startup=1

" ============= jedi =============
let g:jedi#force_py_version=3

" ============= rust =============
let g:rustfmt_autosave=1
let g:rust_clip_command='xclip -selection clipboard'
let g:racer_experimental_completer=1

" ============= signify =============
let g:signify_vcs_list = ['git']
let g:signify_sign_change = '~'

" ============= vim-terraform =============
let g:terraform_align=1
let g:terraform_fmt_on_save=1

" ============= vim-airline =============
let g:airline_extensions = []
