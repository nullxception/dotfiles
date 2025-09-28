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
                desc = "findfiles",
                key = "f",
                keymap = "<leader>ff",
                action = "Telescope find_files",
            },
            {
                icon = "󱎸 ",
                icon_hl = "Title",
                desc = "livegrep",
                key = "g",
                keymap = "<leader>lg",
                action = "Telescope live_grep",
            },
            {
                icon = "󱀼 ",
                icon_hl = "Title",
                desc = "oldfiles",
                key = "o",
                keymap = "<leader>fo",
                action = "Telescope oldfiles",
            },
            {
                icon = "󱏒 ",
                icon_hl = "Title",
                desc = "filebrowser",
                key = "b",
                keymap = "<leader>fb",
                action = "Telescope file_browser",
            },
        },
        footer = {},
    },
    hide = {
        statusline = false,
    },
}
