local success, _ = pcall(require, "lualine")
if not success then
    return
end

require('lualine').setup({
    options = {
        theme = 'tokyonight',
        globalstatus = true,
    },
})
