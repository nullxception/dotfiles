local utils = require("nxc.utils")
local herta = require("nxc.ascii.herta")

return {
    theme = "doom",
    config = {
        header = utils.build_header({
            data = herta.normal,
            padding_bottom = 1,
        }),
        center = {
            {
                icon = "󰮗 ",
                icon_hl = "Title",
                desc = "find files",
                key = "f",
                keymap = "<leader>ff",
                action = "Telescope find_files",
            },
            {
                icon = "󱎸 ",
                icon_hl = "Title",
                desc = "find string",
                key = "s",
                keymap = "<leader>fg",
                action = "Telescope live_grep",
            },
            {
                icon = "󱀼 ",
                icon_hl = "Title",
                desc = "old files",
                key = "o",
                keymap = "<leader>fo",
                action = "Telescope oldfiles",
            },
            {
                icon = "󱏒 ",
                icon_hl = "Title",
                desc = "browse file",
                key = "b",
                keymap = "<leader>fb",
                action = "Telescope file_browser",
            },
            {
                icon = " ",
                icon_hl = "Title",
                desc = "neogit",
                key = "g",
                keymap = "<leader>gg",
                action = function()
                    require("neogit").open()
                end,
            },
        },
        footer = {},
    },
    hide = {
        statusline = false,
    },
}
