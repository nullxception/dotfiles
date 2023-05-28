-- remove trailing whitespaces at the end of the line(s)
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = "*",
    callback = function()
        if vim.bo.filetype == 'markdown' then
            return
        end
        vim.cmd[[%s/\s\+$//e]]
    end,
})
