local lsp_path = vim.fn.expand("$MASON/packages/powershell-editor-services")
if vim.uv.fs_stat(lsp_path) == nil then
    return {}
end

return {
    filetypes = { "ps1", "psm1", "psd1" },
    bundle_path = lsp_path,
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
