---@param repo string
---@return string
_G.gh = function(repo)
    return "https://github.com/" .. repo
end

require("plugins.core")
require("plugins.ui")
require("plugins.lsp")
require("plugins.formatters")
require("plugins.cmp")
require("plugins.telescope")
