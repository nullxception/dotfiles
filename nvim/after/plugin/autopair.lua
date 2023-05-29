local success, _ = pcall(require, "nvim-autopairs")
if not success then
    return
end

require('nvim-autopairs').setup({})
