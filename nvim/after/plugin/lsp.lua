vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = true,
    update_in_insert = true,
})

if vim.fn.executable("kotlin-lsp") ~= nil then
    vim.lsp.enable("kotlin_lsp")
end

vim.lsp.config.jsonls = {
    settings = {
        json = {
            format = { enable = true },
            validate = { enable = true },
            schemas = require("schemastore").json.schemas(),
        },
    },
}

vim.lsp.config.powershell_es = {
    filetypes = { "ps1", "psm1", "psd1" },
    bundle_path = vim.fn.expand("$MASON/packages/powershell-editor-services"),
    settings = {
        powershell = {
            codeFormatting = {
                Preset = "OTBS",
            },
        },
    },
    init_options = {
        enableProfileLoading = false,
    },
}
