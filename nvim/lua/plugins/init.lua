---@param repo string
---@return string
_G.gh = function(repo)
    return "https://github.com/" .. repo
end

require("plugins.essentials")
require("plugins.ui")
require("plugins.lsp")
require("plugins.formatters")
require("plugins.cmp")
require("plugins.telescope")
require("plugins.activities")
require("plugins.tools")
require("plugins.treesitter")
