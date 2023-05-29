local success, _ = pcall(require, "mason")
if not success then
    return
end

require('mason').setup({
    ui = {
        border = "single",
    },
})

require("mason-null-ls").setup({
    ensure_installed = {
        "prettierd",
        "stylua",
        "shfmt"
    }
})
