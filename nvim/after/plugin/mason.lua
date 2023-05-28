require('mason').setup({
    ui = {
        border = "single",
    },
})

require("mason-null-ls").setup({
    ensure_installed = { "prettierd" }
})

