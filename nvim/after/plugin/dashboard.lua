local success, _ = pcall(require, "dashboard")
if not success then
    return
end

local utils = require("nxc.utils")
local hesta = require("nxc.ascii.hesta")

require("dashboard").setup({
    theme = 'doom',
    config = {
        header = utils.build_header({
            data = hesta.normal,
            padding_bottom = 1,
        }),
        center = {
            {
                icon = '󰮗 ',
                icon_hl = 'Title',
                desc = 'findfiles',
                key = 'f',
                keymap = '<leader>ff',
                action = 'Telescope find_files'
            },
            {
                icon = '󱎸 ',
                icon_hl = 'Title',
                desc = 'livegrep',
                key = 'g',
                keymap = '<leader>lg',
                action = 'Telescope live_grep'
            },
            {
                icon = '󱀼 ',
                icon_hl = 'Title',
                desc = 'oldfiles',
                key = 'o',
                keymap = '<leader>fo',
                action = 'Telescope oldfiles'
            },
            {
                icon = '󱏒 ',
                icon_hl = 'Title',
                desc = 'filebrowser',
                key = 'b',
                keymap = '<leader>fb',
                action = 'Telescope file_browser'
            },
        },
        footer = {},
    },
    hide = {
        statusline = false,
    }
})
