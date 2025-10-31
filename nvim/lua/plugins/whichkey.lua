vim.pack.add({ gh("folke/which-key.nvim") }, { confirm = false })
local wk = require("which-key")
wk.setup({
    win = {
        border = "rounded",
    },
})

wk.add({
    "<leader>?",
    function()
        require("which-key").show({ global = false })
    end,
    desc = "Buffer Local Keymaps",
})
