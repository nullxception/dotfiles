vim.pack.add({
    gh("stevearc/conform.nvim"),
    gh("WhoIsSethDaniel/mason-tool-installer.nvim"),
}, { confirm = false })

local formatters = {
    sh = { "shfmt" },
    lua = { "stylua" },
    rust = { "rustfmt" },
}
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
    formatters[ft] = { "prettierd" }
end

local tools = {}
for _, fmts in pairs(formatters) do
    for _, fmt in ipairs(fmts) do
        if fmt == "rustfmt" then
            -- rustfmt should not be installed from mason
            goto skip
        end
        if not vim.tbl_contains(tools, fmt) then
            table.insert(tools, fmt)
        end
        ::skip::
    end
end

require("mason-tool-installer").setup({ ensure_installed = tools })

local conform = require("conform")
conform.setup({
    default_format_opts = {
        lsp_format = "fallback",
    },
    formatters_by_ft = formatters,
})

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
