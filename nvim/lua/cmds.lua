vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = vim.env.MYVIMRC,
    callback = function()
        vim.cmd 'source $MYVIMRC'
        vim.fn['webdevicons#refresh']()
        vim.fn['lightline#init']()
        vim.fn['lightline#colorscheme']()
        vim.fn['lightline#update']()
    end
})
