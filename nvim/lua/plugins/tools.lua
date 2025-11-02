vim.pack.add({
    gh("tpope/vim-fugitive"),
    gh("sindrets/diffview.nvim"),
    gh("NeogitOrg/neogit"),
    gh("lambdalisue/suda.vim"),
    gh("NMAC427/guess-indent.nvim"),
}, { confirm = false })

require("neogit").setup({
    integrations = {
        diffview = true,
    },
    graph_style = "kitty",
})
vim.keymap.set("n", "<leader>ng", require("neogit").open, { desc = "NeoGit", silent = true })

require("guess-indent").setup({})
