---@param repo string
---@return string
_G.gh = function(repo)
    return "https://github.com/" .. repo
end

vim.pack.add({ gh("mason-org/mason.nvim") }, { confirm = false })

require("mason").setup({})

require("plugins.ui")
require("plugins.lsp")
require("plugins.telescope")
