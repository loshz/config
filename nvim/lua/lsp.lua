local lsp = require("lspconfig")

local on_attach = function(client, bufnr)
    client.server_capabilities.semanticTokensProvider = nil
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = {noremap = true, silent = true, buffer = bufnr}
    vim.keymap.set("n", "<Leader>d", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float, bufopts)
    vim.keymap.set("n", "<Leader>h", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "<Leader>r", vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<Leader>td", vim.lsp.buf.type_definition, bufopts)
end

-- Disable inline LSP errors.
vim.diagnostic.config({
    virtual_text = false,
})

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

lsp.rust_analyzer.setup(
    {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                autoimport = {
                    enable = true
                },
				cargo = {
                    buildScripts = {
                        enable = true,
                    },
                },
                checkOnSave = {
                    command = "clippy"
                },
				procMacro = {
                    enable = true
                },
            }
        }
    }
)

lsp.clangd.setup(
    {
        capabilities = capabilities,
        on_attach = on_attach
    }
)

lsp.gopls.setup(
    {
        capabilities = capabilities,
        on_attach = on_attach
    }
)

local cmp = require("cmp")
cmp.setup(
    {
        snippet = {
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body)
            end
        },
        -- mapping = {
        --   ['<C-p>'] = cmp.mapping.select_prev_item(),
        --   ['<C-n>'] = cmp.mapping.select_next_item(),
        --   ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        --   ['<Tab>'] = cmp.mapping.select_next_item(),
        --   ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        --   ['<C-f>'] = cmp.mapping.scroll_docs(4),
        --   ['<C-Space>'] = cmp.mapping.complete(),
        --   ['<C-e>'] = cmp.mapping.close(),
        --   ['<CR>'] = cmp.mapping.confirm({
        --     behavior = cmp.ConfirmBehavior.Insert,
        --     select = true,
        --   })
        -- },
        mapping = cmp.mapping.preset.insert(
            {
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.close(),
                ["<CR>"] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true
                },
                ["<Tab>"] = cmp.mapping(
                    function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end,
                    {"i", "s"}
                ),
                ["<S-Tab>"] = cmp.mapping(
                    function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end,
                    {"i", "s"}
                )
            }
        ),
        sources = {
            {name = "nvim_lsp"},
            {name = "nvim_lsp_signature_help"},
            {name = "vsnip"},
            {name = "buffer"},
            {name = "path"}
        }
    }
)
