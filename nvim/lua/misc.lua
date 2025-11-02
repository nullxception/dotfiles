local severity = { min = vim.diagnostic.severity.WARN }
vim.diagnostic.config({
    float = true,
    update_in_insert = true,
    jump = { severity = severity },
    signs = { severity = severity },
    virtual_lines = false,
    virtual_text = { severity = severity },
})

local augroup = vim.api.nvim_create_augroup("UserMiscAuto", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup,
    callback = function()
        vim.hl.on_yank()
    end,
})
