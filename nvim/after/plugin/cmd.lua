local function cleanup_trailing_spaces()
    if vim.bo.filetype == "markdown" then
        return
    end
    vim.cmd([[%s/\s\+$//e]])
end

local function conform_format(args)
    local success, conform = pcall(require, "conform")
    if not success then
        return
    end
    conform.format({ bufnr = args.buf })
end

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        cleanup_trailing_spaces()
        conform_format(args)
    end,
})
