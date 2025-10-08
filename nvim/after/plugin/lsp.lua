vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = true,
    update_in_insert = true,
})

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

if vim.fn.executable("kotlin-lsp") ~= nil then
    vim.lsp.enable("kotlin_lsp")
end
