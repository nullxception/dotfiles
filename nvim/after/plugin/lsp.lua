local real_create = vim.lsp.client.create

vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = true,
    update_in_insert = true,
})

vim.lsp.client.create = function(config)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    return real_create(vim.tbl_deep_extend("keep", config, {
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities),
    }))
end

vim.lsp.config.lua_ls = {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
        },
    },
}
