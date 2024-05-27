-- https://neovim.io/doc/user/lua-guide.html
local api = vim.api
local cmd = vim.cmd
local g = vim.g
local opt = vim.opt

-- Plugins
-- https://github.com/junegunn/vim-plug
local plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')
plug 'fatih/vim-go'
plug 'hashivim/vim-terraform'
plug 'hrsh7th/cmp-buffer'
plug 'hrsh7th/cmp-path'
plug 'hrsh7th/cmp-nvim-lsp'
plug 'hrsh7th/cmp-vsnip'
plug 'hrsh7th/nvim-cmp'
plug 'hrsh7th/vim-vsnip'
plug 'junegunn/fzf'
plug 'junegunn/fzf.vim'
plug 'mhinz/vim-signify'
plug 'neovim/nvim-lspconfig'
plug 'ntpeters/vim-better-whitespace'
plug 'rhysd/vim-clang-format'
plug 'rust-lang/rust.vim'
plug 'tpope/vim-commentary'
plug 'tpope/vim-fugitive'
plug 'ziglang/zig.vim'
vim.call('plug#end')

-- General
opt.clipboard = 'unnamedplus'
opt.completeopt = 'menuone,noinsert,noselect'
opt.shortmess:append('c')
opt.signcolumn = 'yes'
opt.ignorecase = true
opt.smartcase = true

-- Statusline
opt.laststatus = 2
opt.statusline = '%F %m%h%r%= %{trim(system("git branch --show-current 2>/dev/null"))} | %l:%L %{&fenc}%y'

-- UI
opt.termguicolors = true
cmd('colorscheme dark')
opt.number = true
opt.cursorline = true
opt.showmatch = true
opt.matchtime = 2
opt.mouse = 'a'
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

-- Mappings
g.mapleader = ','

api.nvim_set_keymap('n', '<leader>c', ':Commentary<CR>', { noremap = true })
api.nvim_set_keymap('n', '<leader>g', ':GitFiles<CR>', { noremap = true })
api.nvim_set_keymap('n', '<leader>f', ':Files<CR>', { noremap = true })

api.nvim_command([[
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
]])

local proto = api.nvim_create_augroup('proto', { clear = false })
api.nvim_create_autocmd({ 'BufWritePost' }, {
  pattern = '*.proto',
  group = proto,
  command = 'silent !buf format -w',
})

-- clang
g['clang_format#auto_filetypes'] = { 'c', 'cpp' }
g['clang_format#auto_format'] = 1
g['clang_format#detect_style_file'] = 1

-- go
g.go_fmt_command = 'goimports'
g.go_highlight_fields = 1
g.go_highlight_functions = 1
g.go_highlight_methods = 1
g.go_highlight_structs = 1
g.go_highlight_types = 1
g.go_highlight_operators = 1
g.go_highlight_extra_types = 1
g.go_highlight_build_constraints = 1
g.go_highlight_generate_tags = 1
g.go_metalinter_autosave = 1
g.go_jump_to_error = 0
g.go_template_autocreate = 0

-- rust
g.rustfmt_autosave = 1

-- signify
g.signify_vcs_list = { 'git' }
g.signify_sign_change = '~'

-- vim-terraform
g.terraform_align = 1
g.terraform_fmt_on_save = 1
