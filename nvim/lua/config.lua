local api = vim.api
local cmd = vim.cmd
local glob = vim.g
local opts = vim.opt

-- General
opts.clipboard:append('unnamed', 'unnamedplus')
opts.completeopt = 'menuone,noinsert,noselect'
opts.shortmess:append('c')
opts.signcolumn = 'yes'
opts.ignorecase = true
opts.smartcase = true

-- UI
cmd('colorscheme dark')
opts.number = true
opts.cursorline = true
opts.showmatch = true
opts.matchtime = 2
opts.mouse = 'a'
opts.tabstop = 4
opts.softtabstop = 4
opts.shiftwidth = 4

-- Mappings
glob.mapleader = ','

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

augroup proto
  autocmd BufWritePost *.proto silent !buf format -w
augroup END
]])

-- clang
glob['clang_format#auto_filetypes'] = { 'c', 'cpp' }
glob['clang_format#auto_format'] = 1
glob['clang_format#detect_style_file'] = 1

-- go
glob.go_fmt_command = 'goimports'
glob.go_highlight_fields = 1
glob.go_highlight_functions = 1
glob.go_highlight_methods = 1
glob.go_highlight_structs = 1
glob.go_highlight_types = 1
glob.go_highlight_operators = 1
glob.go_highlight_extra_types = 1
glob.go_highlight_build_constraints = 1
glob.go_highlight_generate_tags = 1
glob.go_metalinter_autosave = 1
glob.go_jump_to_error = 0
glob.go_template_autocreate = 0

-- rust
glob.rustfmt_autosave = 1

-- signify
glob.signify_vcs_list = { 'git' }
glob.signify_sign_change = '~'

-- vim-terraform
glob.terraform_align = 1
glob.terraform_fmt_on_save = 1

-- LSP
require('lsp')
