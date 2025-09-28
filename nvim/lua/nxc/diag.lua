local severity = { min = vim.diagnostic.severity.WARN }
vim.diagnostic.config({
    float = true,
    update_in_insert = true,
    jump = { severity = severity },
    signs = { severity = severity },
    virtual_lines = false,
    virtual_text = { severity = severity },
})
