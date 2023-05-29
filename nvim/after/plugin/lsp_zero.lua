local success, _ = pcall(require, "lsp-zero")
if not success then
    return
end

local lsp = require("lsp-zero").preset({})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
    lsp.buffer_autoformat()
end)

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
lsp.setup()

local cmp = require('cmp')
require('luasnip.loaders.from_vscode').lazy_load()
cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer',  keyword_length = 3 },
        { name = 'luasnip', keyword_length = 2 },
        { name = 'path' },
        { name = 'nvim_lua' },
    },
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }
})
