vim.pack.add({
    gh("stevearc/conform.nvim"),
    gh("zapling/mason-conform.nvim"),
}, { confirm = false })

local fts = {
    sh = { "shfmt" },
    lua = { "stylua" },
    rust = { "rustfmt" },
}
if vim.fn.executable("npm") == 1 then
    local prettierft = {
        "css",
        "less",
        "scss",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "html",
        "json",
        "yaml",
        "markdown",
    }
    for _, ft in ipairs(prettierft) do
        fts[ft] = { "prettierd" }
    end
end

local conform = require("conform")
conform.setup({
    default_format_opts = {
        lsp_format = "fallback",
    },
    formatters_by_ft = fts,
})
require("mason-conform").setup({})

local function cleanup_trailing_spaces()
    if vim.bo.filetype == "markdown" then
        return
    end
    vim.cmd([[%s/\s\+$//e]])
end

local augroup = vim.api.nvim_create_augroup("UserConformAuto", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    pattern = "*",
    callback = function(args)
        cleanup_trailing_spaces()
        conform.format({ bufnr = args.buf })
    end,
})
