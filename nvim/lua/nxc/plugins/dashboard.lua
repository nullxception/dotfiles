local dash = require("nxc.dashboard")
local herta = require("nxc.dashboard.herta")

---@module "lazy"
---@type LazySpec
return {
    {
        "glepnir/dashboard-nvim",
        event = "VimEnter",
        opts = {
            theme = "doom",
            config = {
                header = dash.build_header({
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
                        keymap = "<leader>fg",
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
                        key = "B",
                        keymap = "<leader>fB",
                        action = "Telescope file_browser",
                    },
                    {
                        icon = " ",
                        icon_hl = "Title",
                        desc = "neogit",
                        key = "n",
                        keymap = "<leader>ng",
                        action = "Neogit",
                    },
                    {
                        icon = " ",
                        icon_hl = "Title",
                        desc = "terminal",
                        key = "`",
                        keymap = "<A-`>",
                        action = function()
                            require("snacks").terminal()
                        end,
                    },
                },
                footer = {},
            },
            hide = {
                statusline = false,
            },
        },
    },
}
