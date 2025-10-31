vim.pack.add({
    gh("mason-org/mason.nvim"),
    gh("nvim-mini/mini.icons"),
}, { confirm = false })

local icons = require("mini.icons")
icons.setup({})
icons.mock_nvim_web_devicons()
require("mason").setup({})
