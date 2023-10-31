-- General
vim.opt.clipboard = 'unnamedplus'
vim.opt.completeopt = 'menuone,noinsert,noselect'
vim.opt.shortmess:append('c')
vim.opt.signcolumn = 'yes'
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- UI
vim.cmd('colorscheme dark')
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.showmatch = true
vim.opt.matchtime = 2
vim.opt.mouse = 'a'
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Mappings
vim.g.mapleader = ','

vim.api.nvim_set_keymap('n', '<leader>c', ':Commentary<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>g', ':GitFiles<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>f', ':Files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>n', ':Lexplore<CR>', { noremap = true })

vim.api.nvim_command([[
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

-- netrw
vim.g.netrw_altv=1
vim.g.netrw_banner=0
vim.g.netrw_browse_split=4
vim.g.netrw_liststyle=3
vim.g.netrw_winsize=15

-- clang
vim.g['clang_format#auto_filetypes'] = ['c', 'cpp']
vim.g['clang_format#auto_format'] = 1
vim.g['clang_format#detect_style_file'] = 1

-- go
vim.g.go_fmt_command='goimports'
vim.g.go_highlight_fields=1
vim.g.go_highlight_functions=1
vim.g.go_highlight_methods=1
vim.g.go_highlight_structs=1
vim.g.go_highlight_types=1
vim.g.go_highlight_operators=1
vim.g.go_highlight_extra_types=1
vim.g.go_highlight_build_constraints=1
vim.g.go_highlight_generate_tags=1
vim.g.go_metalinter_autosave=1
vim.g.go_jump_to_error=0
vim.g.go_template_autocreate=0

-- rust
vim.g.rustfmt_autosave=1

-- signify
vim.g.signify_vcs_list=['git']
vim.g.signify_sign_change='~'

-- vim-terraform
vim.g.terraform_align=1
vim.g.terraform_fmt_on_save=1

-- LSP
require('lsp')
