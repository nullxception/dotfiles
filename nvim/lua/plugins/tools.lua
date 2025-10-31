vim.pack.add({
    gh("tpope/vim-fugitive"),
    gh("sindrets/diffview.nvim"),
    gh("NeogitOrg/neogit"),
    gh("lambdalisue/suda.vim"),
}, { confirm = false })

require("neogit").setup({
    integrations = {
        diffview = true,
    },
    graph_style = "kitty",
})
vim.keymap.set("n", "<leader>ng", require("neogit").open, { desc = "NeoGit", silent = true })
